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

	  list query, "未结算订单"
	end

	def settled
	  query = Biz::Order.for_finance(current_user)
	                    .includes(draft: :user)
	                    .where(is_settled: true)
	                    .order(created_at: :desc)
	                    
	  list query, "已结算订单"
	end

	def list(query, filename)
    if params[:order_no_or_draft_name].present?
      keyword = params[:order_no_or_draft_name]
      query = query.where("order_no = ? OR draft_name LIKE ?", keyword, "%#{keyword}%")
    end
    query = query.where("biz_order.created_at >= ?", params[:start_date].to_date.beginning_of_day) if params[:start_date].present?
    query = query.where("biz_order.created_at <= ?", params[:end_date].to_date.end_of_day) if params[:end_date].present?

    respond_to do |format|
	    format.html {
	    	@pagy, @orders = pagy(:offset, query, limit: 5)
	    }
	    format.xlsx {
	    	@orders = query
	      # 这里调用你的导出逻辑，比如使用 axlsx_rails
	      response.headers['Content-Disposition'] = "attachment; filename=\"#{filename}.xlsx\""
	    }
	  end
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
