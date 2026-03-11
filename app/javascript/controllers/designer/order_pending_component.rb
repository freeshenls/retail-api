# app/components/designer/order_pending_component.rb
class Designer::OrderPendingComponent < ViewComponent::Base
  def initialize(orders:)
    @orders = orders
  end
end
