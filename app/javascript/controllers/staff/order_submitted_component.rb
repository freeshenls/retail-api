# app/components/staff/order_submitted_component.rb
class Staff::OrderSubmittedComponent < ViewComponent::Base
  def initialize(orders:, pagy:)
    @orders = orders
    @pagy = pagy
  end
end
