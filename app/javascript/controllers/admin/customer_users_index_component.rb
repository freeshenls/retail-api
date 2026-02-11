# app/components/admin/customer_users_index_component.rb
class Admin::CustomerUsersIndexComponent < ViewComponent::Base
  def initialize(customers:, selected_customer: nil)
    @customers = customers
    @selected_customer = selected_customer || customers.first
    
    # 核心逻辑：只显示该客户尚未关联的员工
    if @selected_customer
      @available_users = Sys::User.where.not(id: @selected_customer.user_ids).order(name: :asc)
    else
      @available_users = []
    end
  end
end
