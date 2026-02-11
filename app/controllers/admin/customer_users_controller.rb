# app/controllers/admin/customer_users_controller.rb
class Admin::CustomerUsersController < ApplicationController
  def index
    @customers = Biz::Customer.all.includes(:users).order(name: :asc)
    @selected_customer = Biz::Customer.find_by(id: params[:customer_id]) || @customers.first
    # 下拉框只显示未指派的人
    @available_users = Sys::User.where.not(id: @selected_customer&.user_ids || []).order(name: :asc)
  end

  def create
    @customer = Biz::Customer.find(params[:customer_id])
    user = Sys::User.find(params[:user_id])
    Biz::CustomerUser.find_or_create_by!(customer: @customer, user: user)
    
    redirect_to admin_customer_users_path(customer_id: @customer.id), notice: "关联成功"
  end

  def destroy
    @customer = Biz::Customer.find(params[:customer_id])
    relation = Biz::CustomerUser.find_by(customer_id: @customer.id, user_id: params[:id])
    relation&.destroy
    
    redirect_to admin_customer_users_path(customer_id: @customer.id), notice: "已取消关联"
  end
end