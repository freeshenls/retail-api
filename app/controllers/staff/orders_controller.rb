# app/controllers/staff/orders_controller.rb
module Staff
  class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_order, only: [:accept, :approve, :reject, :show, :edit, :update]

    def ready
      query = Biz::Order.where(staff_id: nil)
                  .order(updated_at: :desc)

      @pagy, @orders = pagy(:offset, query, limit: 5)
    end

    def submitted
      query = Biz::Order.for_staff(current_user)
                  .where(status: :submitted)
                  .order(updated_at: :desc)

      @pagy, @orders = pagy(:offset, query, limit: 5)
    end

    def approved
      query = Biz::Order.for_staff(current_user)
                  .where(status: [:approved, :received])
                  .order(updated_at: :desc)

      @pagy, @orders = pagy(:offset, query, limit: 5)
    end

    def rejected
      query = Biz::Order.for_staff(current_user)
                  .where(status: :rejected)
                  .order(updated_at: :desc)

      @pagy, @orders = pagy(:offset, query, limit: 5)
    end

    def all
      query = Biz::Order.for_staff(current_user)
                  .order(updated_at: :desc)

      @pagy, @orders = pagy(:offset, query, limit: 5)
    end

    def show
    end

    def edit
    end

    def update
      @order.update(order_params)

      # 不关心字段
      changes = @order.saved_changes.except("unit_id", "updated_at")

      # 通知
      Biz::Notification.where(target: @order, action: :adjusted).destroy_all
      Biz::Notification.create!(
        user: @order.draft.user,
        actor: current_user,
        target: @order,
        action: 'adjusted',
        metadata: changes.transform_keys { |k| Biz::Order.human_attribute_name(k) }.to_h
      )
      
      @order.broadcast_designer_notifications
      redirect_to staff_order_path(@order), status: :see_other, notice: "订单已更新" 
    end

    def accept
      # 强制绑定当前员工，不改变 status，直接重定向
      @order.update(staff: current_user)
      redirect_to submitted_staff_orders_path, notice: "接单成功"
    end

    def approve
      @order.update(status: :approved)
      redirect_to approved_staff_orders_path, notice: "已发货"
    end

    def reject
      @order.update(status: :rejected, reject_reason: params[:biz_order][:reject_reason])
      # 退回后跳转到待处理列表或已驳回列表
      redirect_to all_staff_orders_path, notice: "订单已成功退回"
    end

    private

    def set_order
      @order = Biz::Order.find(params[:id])
    end

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
  end
end
