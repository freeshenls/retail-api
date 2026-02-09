# app/components/finance/order_settled_component.rb
class Admin::OrderSettledComponent < ViewComponent::Base
  def initialize(orders:, pagy:)
    @orders = orders
    @pagy = pagy
  end
end
