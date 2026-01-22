# frozen_string_literal: true

class Designer::OrderShowComponent < ViewComponent::Base
	def initialize(order:)
    @order = order
  end
end
