# app/components/front/order_approved_component.rb

class Front::OrderApprovedComponent < ViewComponent::Base

  def initialize(orders:, all_orders:)
    @orders = orders
    @all_orders = all_orders
  end
end
