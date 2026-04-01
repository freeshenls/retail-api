# frozen_string_literal: true

class OrderQuery::AdminComponent < ViewComponent::Base

	def initialize(url:, can_export: false, export_url: nil)
    @url = url
    @can_export = can_export
    @export_url = export_url
    @customers = Biz::Customer.order(:name).select(:id, :name)
    @users = Sys::User.where(role: Sys::Role.find_by(:name => :staff)).order(:name).select(:id, :name)
  end
end
