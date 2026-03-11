# app/components/admin/order_index_component.rb
class Admin::OrderIndexComponent < ViewComponent::Base
  
  def initialize(orders:)
    @orders = orders
  end
end
