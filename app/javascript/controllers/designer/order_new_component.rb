# app/javascript/controllers/designer/order_new_component.rb
class Designer::OrderNewComponent < ViewComponent::Base
  include Rails.application.routes.url_helpers

  # app/javascript/controllers/designer/order_new_component.rb
  def initialize(user:)
    @user = user
    @customers = @user.customers
    @categories = Biz::Category.order(:position)
    @units = Biz::Unit.all.includes(:category)

    # 1. 找到默认值
    default_customer = @customers.first
    default_category = @categories.first
    # 寻找第一个分类对应的第一个服务项目（规格）
    default_unit = @units.find { |u| u.category_id == default_category&.id }

    # 2. 预设订单数据
    @order = Biz::Order.new(
      order_no: Biz::Sequence.generate_next_no,
      status: :pending,
      customer_id: default_customer&.id,
      unit_id: default_unit&.id,
      payment_method: "微信"
    )
    @order.build_draft(user: @user)
  end

  private
  attr_reader :user, :order, :customers, :categories, :units
end
