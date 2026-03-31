# app/components/staff/order_approved_component.rb
class Staff::OrderAllComponent < ViewComponent::Base
  
  def initialize(orders:)
    @orders = orders
  end
end
