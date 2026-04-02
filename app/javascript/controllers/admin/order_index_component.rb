# app/components/admin/order_index_component.rb
class Admin::OrderIndexComponent < ViewComponent::Base
  
  def initialize(orders:, all_orders:)
    @orders = orders
    @all_orders = all_orders
  end
end
