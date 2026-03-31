# frozen_string_literal: true

class OrderAction::DestroyComponent < ViewComponent::Base

	def initialize(order:)
    @order = order
  end
end
