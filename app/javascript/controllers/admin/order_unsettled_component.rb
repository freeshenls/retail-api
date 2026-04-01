# app/javascript/controllers/admin/order_unsettled_component.rb
class Admin::OrderUnsettledComponent < ViewComponent::Base
  
  def initialize(orders:)
    @orders = orders
  end
end
