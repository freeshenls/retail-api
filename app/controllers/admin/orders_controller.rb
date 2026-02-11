class Admin::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit]

	def show
	end

	def edit
	end

	def update
	  @order = Biz::Order.find(params[:id])
	  
	  @order.update(order_params)
    # 成功后重定向回详情页
    redirect_to admin_order_path(@order), notice: "账务信息已同步"
	end

	def unsettled
	  # 只需要 includes 稿件和稿件的设计师
	  query = Biz::Order.includes(draft: :user) 
	                    .where(is_settled: false)
	                    .order(created_at: :desc)

	  @pagy, @orders = pagy(:offset, query, limit: 5)
	end

	def settled
	  query = Biz::Order.includes(draft: :user)
	                    .where(is_settled: true)
	                    .order(created_at: :desc)
	                    
	  @pagy, @orders = pagy(:offset, query, limit: 5)
	end

	private

	def set_order
		@order = Biz::Order.includes(:staff, :customer, draft: { file_attachment: :blob, user: {} })
                    .find(params[:id])
	end


	def order_params
	  # 确保这里包含 :is_settled
	  params.require(:order).permit(:name, :is_settled, :credit_limit, :card_no, :card_name, :address)
	end
end
