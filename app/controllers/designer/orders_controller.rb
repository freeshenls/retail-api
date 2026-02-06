# app/controllers/designer/orders_controller.rb
class Designer::OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update, :show]

  def new
    # 此处由 OrderNewComponent 接管渲染
  end

  def create
    @order = Biz::Order.new(order_params)
  
    if @order.save
      respond_to do |format|
        # 方案 A：由 JS 处理跳转（保持你之前要求的“由 JS 跳”）
        format.turbo_stream { head :no_content }
        format.html {
          # 即使是普通 HTML 提交，我们也根据 status 自动分流
          path = @order.submitted? ? completed_designer_orders_path : pending_designer_orders_path
          redirect_to path, notice: "订单 #{@order.order_no} 操作成功"
        }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def pending
    # 设计师视角：显示所有“待处理”或“被退回”且“未结算”的订单
    query = Biz::Order.for_designer(current_user)
                      .includes(draft: :user)
                      .where(status: [:pending, :rejected], is_settled: false)
                      .order(created_at: :desc)
    
    @pagy, @orders = pagy(:offset, query, limit: 5)
  end

  def completed
    # 设计师视角：显示“已提交审核”、“已审核”或“已结算”的订单
    query = Biz::Order.for_designer(current_user)
                      .includes(draft: :user)
                      .where.not(status: [:pending, :rejected])
                      .order(updated_at: :desc)
    
    @pagy, @orders = pagy(:offset, query, limit: 5)
  end

  def edit
    # 渲染更新组件
  end

  def update
    if @order.update(order_params)
      respond_to do |format|
        # 情况 A：如果是从下拉框 Dialog 发来的“确认收货”，保持静默
        # 这里不返回任何内容，浏览器不跳转，UI 等待 Model 的广播
        format.turbo_stream { head :no_content } 
        
        # 情况 B：如果是编辑表单提交，执行常规跳转
        format.html { 
          path = @order.submitted? ? completed_designer_orders_path : pending_designer_orders_path
          redirect_to path, notice: "订单已处理" 
        }
      end
    else
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
      :status,
      draft_attributes: [:id, :file, :user_id] # update 动作建议加上 :id 以便更新现有附件
    )
  end

  def set_order
    @order = Biz::Order.find(params[:id])
  end
end
