# frozen_string_literal: true

class OrderQuery::NormalComponent < ViewComponent::Base
  
	def initialize(url:, can_export: false, export_url: nil)
    @url = url
    @can_export = can_export
    @export_url = export_url
  end
end
