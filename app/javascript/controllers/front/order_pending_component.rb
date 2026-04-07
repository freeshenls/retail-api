# app/components/front/order_pending_component.rb
class Front::OrderPendingComponent < ViewComponent::Base
  def initialize(orders:)
    @orders = orders
  end
end
