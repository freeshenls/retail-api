# app/components/designer/order_completed_component.rb
class Designer::OrderCompletedComponent < ViewComponent::Base

  def initialize(orders:, pagy:)
    @orders = orders
    @pagy = pagy
  end
end
