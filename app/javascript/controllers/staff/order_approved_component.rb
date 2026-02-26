# app/components/staff/order_approved_component.rb
class Staff::OrderApprovedComponent < ViewComponent::Base
  def initialize(orders:, pagy:)
    @orders = orders
    @pagy = pagy
  end
end
