# app/components/staff/order_edit_component.rb
class Staff::OrderEditComponent < ViewComponent::Base
  def initialize(order:)
    @order = order
    # 修复点：直接返回对象，不转成数组，确保兼容 c.id 和 c.name
    @customers = Biz::Customer.all.order(name: :asc)
    @categories = Biz::Category.all.order(position: :asc)
    
    # 供 JS 计算使用的 JSON 数据保持不变
    @units_json = Biz::Unit.all.map { |u| 
      { service_type: u.service_type, category_id: u.category_id, price: u.price.to_f, unit_id: u.id } 
    }.to_json
    
    @payment_methods = ["微信", "支付宝", "现金", "对公", "记账"]
  end
end

