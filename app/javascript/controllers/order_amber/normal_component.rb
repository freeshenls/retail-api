# frozen_string_literal: true

class OrderAmber::NormalComponent < ViewComponent::Base

	def initialize(order:, title:, show_time:)
    @order = order
    @title = title
    @show_time = show_time
  end
end
