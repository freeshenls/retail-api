class Finance::OrdersController < ApplicationController
  before_action :set_order, only: [:update]

	def show
		@order = Biz::Order.for_finance(current_user)
                    .includes(:staff, :customer, draft: { file_attachment: :blob, user: {} })
                    .find(params[:id])
	end

	def unsettled
	  # 只需要 includes 稿件和稿件的设计师
	  query = Biz::Order.for_finance(current_user)
	                    .includes(draft: :user) 
	                    .where(is_settled: false)
	                    .order(created_at: :desc)

	  @pagy, @orders = pagy(:offset, query, limit: 5)
	end

	def settled
	  query = Biz::Order.for_finance(current_user)
	                    .includes(draft: :user)
	                    .where(is_settled: true)
	                    .order(created_at: :desc)
	                    
	  @pagy, @orders = pagy(:offset, query, limit: 5)
	end

	def update
    @order.update(order_params)
    redirect_to request.path, notice: "订单已核实" 
  end

  private

  def set_order
		@order = Biz::Order.find(params[:id])
	end

	def order_params
		params.require(:order).permit(:status)
  end
end
