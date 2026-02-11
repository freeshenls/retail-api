# app/components/staff/order_show_component.rb
class Staff::OrderShowComponent < ViewComponent::Base
  def initialize(order:)
    @order = order
  end

  private

  def status_label
    @order.status == "approved" ?  "已发货" : @order.staff.nil? ? "等待抢单" : "等待发货"
  end
end
