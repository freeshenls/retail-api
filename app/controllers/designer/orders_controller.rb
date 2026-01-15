# app/controllers/designer/orders_controller.rb
class Designer::OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update]

  def pending
    # 设计师视角：显示所有“待处理”或“被退回”且“未结算”的订单
    # 这样如果审核没通过被驳回，会重新出现在这个列表中
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
    # 1. 自动从关联的 unit 获取冗余字段（如 service_type, category_name）
    # 2. 将状态改为 submitted (提交审核)
    # 3. 计算总金额 amount (也可以放在 Model 的 before_save 里)
    
    update_data = order_params.merge(status: 'submitted')

    # 如果传了 unit_id，我们尝试同步冗余名称信息
    if params[:biz_order][:unit_id].present?
      unit = Biz::Unit.find_by(id: params[:biz_order][:unit_id])
      if unit
        update_data[:service_type] = unit.service_type
        update_data[:category_name] = unit.category&.name
      end
    end

    if @order.update(update_data)
      # 提交审核后，跳转到“已完成/已提交”页面
      redirect_to completed_designer_orders_path, notice: "工单已提交财务审核"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_order
    @order = Biz::Order.find(params[:id])
  end

  def order_params
    # 增加组件中涉及的所有字段
    params.require(:biz_order).permit(
      :customer_id,
      :unit_id,
      :quantity, 
      :unit_price, 
      :delivery_fee, 
      :delivery_method, 
      :payment_method,
      :remark
    )
  end
end
