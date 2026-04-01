# app/javascript/controllers/finance/order_unsettled_component.rb
class Finance::OrderUnsettledComponent < ViewComponent::Base
  
  def initialize(orders:)
    @orders = orders
  end
end
