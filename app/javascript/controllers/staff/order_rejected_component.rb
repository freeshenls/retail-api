# app/components/staff/order_rejected_component.rb
class Staff::OrderRejectedComponent < ViewComponent::Base
  def initialize(orders:, pagy:)
    @orders = orders
    @pagy = pagy
  end

  private

  def render_pagy?
    @pagy.present? && @pagy.pages > 1
  end
end
