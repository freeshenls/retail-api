# frozen_string_literal: true

class OrderAction::NormalComponent < ViewComponent::Base

	def initialize(url:, params:, title:, sub_title:, hint:, sub_hint:)
    @url = url
    @params = params
    @title = title
    @sub_title = sub_title
    @hint = hint
    @sub_hint = sub_hint
  end
end
