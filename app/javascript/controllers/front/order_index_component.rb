# app/components/front/order_index_component.rb
class Front::OrderIndexComponent < ViewComponent::Base
  
  def initialize(orders:, all_orders:)
    @orders = orders
    @all_orders = all_orders
  end
end
