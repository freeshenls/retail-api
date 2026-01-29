# app/components/staff/order_show_component.rb
class Staff::OrderShowComponent < ViewComponent::Base
  def initialize(order:)
    @order = order
  end

  private

  def status_label
    @order.status == "submitted" ? "待审核" : "审核通过"
  end
end
