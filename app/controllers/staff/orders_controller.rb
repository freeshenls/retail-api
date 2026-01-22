# app/controllers/staff/orders_controller.rb
class Staff::OrdersController < ApplicationController
  def index
    # 只看自己负责的订单，或者看到全部？这里以全部为例
    @orders = Biz::Order.order(created_at: :desc)
  end

  def new
    @order = Biz::Order.new
  end

  def create
    @order = Biz::Order.new(order_params)
    @order.staff = current_user # 自动记录当前登录的员工作为制作员
    
    # 自动生成订单号：2026 + 6位自增码
    # 也可以把这个逻辑写在 Biz::Order 的 before_create 回调里
    
    if @order.save
      redirect_to staff_orders_path, notice: "订单创建成功"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:biz_order).permit(
      :customer_id, :draft_id, :unit_id, 
      :quantity, :delivery_fee, :payment_method, 
      :delivery_method, :remark
    )
  end
end
