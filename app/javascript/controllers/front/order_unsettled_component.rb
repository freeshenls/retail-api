# app/javascript/controllers/front/order_unsettled_component.rb
class Front::OrderUnsettledComponent < ViewComponent::Base
  
  def initialize(orders:)
    @orders = orders
  end
end
