# app/components/finance/order_settled_component.rb
class Finance::OrderSettledComponent < ViewComponent::Base
  def initialize(orders:, pagy:)
    @orders = orders
    @pagy = pagy
  end
end
