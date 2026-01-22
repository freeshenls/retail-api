# app/controllers/designer/orders_controller.rb
class Designer::OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update, :show]

  def new
    # 此处由 OrderNewComponent 接管渲染
  end

  def create
    @order = Biz::Order.new(order_params)
    
    # 逻辑判断：是保存待提交还是直接提交
    is_submit = params[:commit_type] == "submit"
    @order.status = is_submit ? "submitted" : "pending"
    
    if @order.save
      # 执行硬跳转，确保业务流转
      if is_submit
        redirect_to completed_designer_orders_path, notice: "订单 #{@order.order_no} 已成功提交审核"
      else
        redirect_to pending_designer_orders_path, notice: "订单 #{@order.order_no} 已保存至待提交列表"
      end
    else
      # 如果校验失败，返回 422 让 Turbo 渲染错误信息
      render :new, status: :unprocessable_entity
    end
  end

  def pending
    # 设计师视角：显示所有“待处理”或“被退回”且“未结算”的订单
    query = Biz::Order.includes(draft: :user)
                      .where(status: [:pending, :rejected], is_settled: false)
                      .order(created_at: :desc)
    
    @pagy, @orders = pagy(:offset, query, limit: 5)
  end

  def completed
    # 设计师视角：显示“已提交审核”、“已审核”或“已结算”的订单
    query = Biz::Order.includes(draft: :user)
                      .where.not(status: [:pending, :rejected])
                      .order(updated_at: :desc)
    
    @pagy, @orders = pagy(:offset, query, limit: 5)
  end

  def edit
    # 渲染更新组件
  end

  def update
    # 1. 识别点击了哪个按钮
    is_submit = params[:commit_type] == "submit"
    
    # 2. 准备更新数据
    # 如果点击“确认并提交”，状态变为 submitted；否则保持 pending
    update_params = order_params.merge(
      status: is_submit ? "submitted" : "pending"
    )

    # 3. 执行更新
    # Model 里的 before_validation 会自动处理名称同步和金额重算
    if @order.update(update_params)
      # 4. 根据状态执行跳转
      if is_submit
        redirect_to completed_designer_orders_path, notice: "订单 #{@order.order_no} 已成功提交审核"
      else
        redirect_to pending_designer_orders_path, notice: "订单 #{@order.order_no} 信息已更新并暂存"
      end
    else
      # 失败则重新渲染编辑页，显示错误
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # 唯一的、合并后的参数控制方法
  def order_params
    params.require(:biz_order).permit(
      :order_no, 
      :customer_id, 
      :unit_id, 
      :quantity, 
      :unit_price, 
      :delivery_fee, 
      :payment_method, 
      :remark,
      draft_attributes: [:id, :file, :user_id] # update 动作建议加上 :id 以便更新现有附件
    )
  end

  def set_order
    @order = Biz::Order.find(params[:id])
  end
end
