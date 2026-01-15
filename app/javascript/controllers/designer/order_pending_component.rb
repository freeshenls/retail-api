# app/components/designer/order_pending_component.rb
class Designer::OrderPendingComponent < ViewComponent::Base
  def initialize(orders:, pagy:)
    @orders = orders || []
    @pagy = pagy
  end
end
