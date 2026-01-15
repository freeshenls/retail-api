# app/components/designer/order_completed_component.rb
class Designer::OrderCompletedComponent < ViewComponent::Base
  def initialize(orders:)
    @orders = orders || []
  end
end
