# frozen_string_literal: true

class OrderQuery::AdminComponent < ViewComponent::Base

	def initialize(url:, type: :all, can_export: false, export_url: nil)
    @url = url
    @can_export = can_export
    @export_url = export_url
    init type
  end

  def init(type)
    if type == :all
      init_all
    elsif type == :customer
      init_customer
    elsif type == :staff
      init_staff
    end
  end

  def init_all
    @show_staff = true
    @show_customer = true
    @desc = "查询主体 (客户/员工)"
    @customers = Biz::Customer.order(:name).select(:id, :name)
    @users = Sys::User.where(role: Sys::Role.find_by(:name => :staff)).order(:name).select(:id, :name)
  end

  def init_customer
    @show_customer = true
    @desc = "查询主体 (客户)"
    @customers = Biz::Customer.order(:name).select(:id, :name)
  end

  def init_staff
    @show_staff = true
    @desc = "查询主体 (员工)"
    @users = Sys::User.where(role: Sys::Role.find_by(:name => :staff)).order(:name).select(:id, :name)
  end
end
