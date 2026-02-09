# app/javascript/controllers/admin/order_edit_component.rb
class Admin::OrderEditComponent < ViewComponent::Base
  def initialize(order:)
    @order = order
  end

  def status_label
    @order.is_settled ? "结算完成" : "等待结算"
  end

  # 获取稿件设计师名称
  def designer_name
    @order.draft&.user&.name || "系统默认"
  end
end
