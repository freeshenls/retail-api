# app/javascript/controllers/staff/order_ready_component.rb
class Staff::OrderReadyComponent < ViewComponent::Base

  def initialize(orders:, pagy:)
    @orders = orders
    @pagy = pagy
  end
end