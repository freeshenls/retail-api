# app/components/finance/order_settled_component.rb
class Admin::OrderSettledComponent < ViewComponent::Base
  
  def initialize(orders:)
    @orders = orders
  end
end
