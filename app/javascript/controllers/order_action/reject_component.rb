# frozen_string_literal: true

class OrderAction::RejectComponent < ViewComponent::Base

	def initialize(order:)
    @order = order
  end
end
