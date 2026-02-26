# app/components/admin/order_index_component.rb
class Admin::OrderIndexComponent < ViewComponent::Base
  def initialize(orders:, q:, pagy:, customers:, users:)
    @orders = orders
    @q = q
    @pagy = pagy
    @customers = customers
    @users = users
  end

  def modes
    [
      { label: "全部", value: "all", icon: "list-bullet" },
      { label: "客户维度", value: "customer", icon: "user-group" },
      { label: "员工维度", value: "user", icon: "identification" }
    ]
  end
end
