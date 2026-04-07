# app/components/front/order_completed_component.rb
class Front::OrderCompletedComponent < ViewComponent::Base

  def initialize(orders:, all_orders:)
    @orders = orders
    @all_orders = all_orders
  end
end
