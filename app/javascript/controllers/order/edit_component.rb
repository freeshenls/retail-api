# frozen_string_literal: true

class Order::EditComponent < ViewComponent::Base
	renders_one :action

	def initialize(user:, order:, url:)
    @url = url
    @user = user
    @order = order
    @categories = Biz::Category.all.order(position: :asc)
    @order.new_record? ? load_new_config : load_edit_config
  end

  def load_new_config
    @method = :post
    @need_file = true
    @icon = "plus"
    @title = "新增订单"
    @amount_title = "预计合计金额"
    @color = "text-blue-600"
    @amount = 0.00
    @customer_cls = ""
    @customer_icon = "chevron-down"
    @display_cls = "text-slate-600"
    @display = "点击上传设计原稿"
    @upload_hint = "支持文件: PDF, AI, JPG, PNG, ZIP"
    @customers = @user.customers.order(name: :asc) if @user.role.name == "designer"
    @customers = Biz::Customer.order(name: :asc) if @user.role.name == "front"
  end

  def load_edit_config
    @method = :patch
    @need_file = false
    @icon = "pencil-square"
    @title = "编辑订单"
    @amount_title = "当前合计金额"
    @color = "text-orange-600"
    @amount = number_with_precision(@order.amount, precision: 2)
    @customer_cls = "pointer-events-none"
    @customer_icon = "lock-closed"
    @display_cls = "text-[#0066b3]"
    @display = @order.draft&.name
    @upload_hint = "点击此处可重新上传覆盖"
    @customers = @order.draft&.user.customers.order(name: :asc)
  end
end
