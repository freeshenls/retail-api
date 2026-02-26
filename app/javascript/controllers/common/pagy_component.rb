# frozen_string_literal: true

class Common::PagyComponent < ViewComponent::Base
	def initialize(pagy:)
    @pagy = pagy
  end
end
