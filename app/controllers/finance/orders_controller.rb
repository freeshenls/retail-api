class Finance::OrdersController < ApplicationController
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

	  @pagy, @orders = pagy(query.order(created_at: :desc), items: 5)
	end

	def settled
	  query = Biz::Order.for_finance(current_user)
	                    .includes(draft: :user)
	                    .where(is_settled: true)

	  @pagy, @orders = pagy(query.order(created_at: :desc), items: 5)
	end
end
