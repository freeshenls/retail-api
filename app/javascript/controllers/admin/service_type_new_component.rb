# frozen_string_literal: true

class Admin::ServiceTypeNewComponent < ViewComponent::Base
	def initialize(service_type:)
    @service_type = service_type
  end
end
