class Designer::OrderUpdateComponent < ViewComponent::Base
  def initialize(order:)
    @order = order
    # 准备下拉选项
    @customers = Biz::Customer.all.map { |c| [c.name, c.id] }
    # 这里的 Unit 包含了 service_type 和 规格(category) 的组合
    @units = Biz::Unit.includes(:category).all.map do |u| 
      ["#{u.service_type} - #{u.category.name}", u.id, { data: { price: u.price } }] 
    end
    @payment_methods = ["微信", "支付宝", "现金", "对公", "记账"]
    @delivery_methods = ["送货", "快递", "自取"]
  end
end
