# frozen_string_literal: true

class OrderAction::ApproveComponent < ViewComponent::Base

	def initialize(order:)
    @order = order
  end
end
