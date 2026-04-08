# app/components/front/order_settled_component.rb
class Front::OrderSettledComponent < ViewComponent::Base
  
  def initialize(orders:)
    @orders = orders
  end
end
