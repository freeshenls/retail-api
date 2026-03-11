# frozen_string_literal: true

class OrderAmber::RejectComponent < ViewComponent::Base

	def initialize(order:)
    @order = order
  end
end
