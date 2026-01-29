# app/controllers/staff/orders_controller.rb
module Staff
  class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_order, only: [:accept, :approve, :reject, :show]

    # 列表页：显示当前员工抢到的待审核订单
    def submitted
      # 使用 pagy 包裹查询
      @pagy, @orders = pagy(
        Biz::Order.for_staff(current_user)
                  .where(status: :submitted)
                  .order(updated_at: :desc),
        items: 5 # 每页数量
      )
    end

    def approved
      # 使用 pagy 包裹查询
      @pagy, @orders = pagy(
        Biz::Order.for_staff(current_user)
                  .where(status: :approved)
                  .order(updated_at: :desc),
        items: 5 # 每页数量
      )
    end

    def rejected
      # 使用 pagy 包裹查询
      @pagy, @orders = pagy(
        Biz::Order.for_staff(current_user)
                  .where(status: :rejected)
                  .order(updated_at: :desc),
        items: 5 # 每页数量
      )
    end

    def show
    end

    def accept
      # 强制绑定当前员工，不改变 status，直接重定向
      @order.update(staff: current_user)
      redirect_to submitted_staff_orders_path, notice: "接单成功"
    end

    def approve
      @order.update(status: :approved)
      redirect_to approved_staff_orders_path, notice: "审核通过"
    end

    def reject
      @order.update(status: :rejected, reject_reason: params[:biz_order][:reject_reason])
      # 退回后跳转到待处理列表或已驳回列表
      redirect_to rejected_staff_orders_path, notice: "订单已成功退回"
    end

    private

    def set_order
      @order = Biz::Order.find(params[:id])
    end
  end
end
