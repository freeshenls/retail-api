# frozen_string_literal: true

class OrderQuery::NormalComponent < ViewComponent::Base
	def initialize(url:)
    @url = url
  end
end
