class Admin::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :destroy]

  def index
    query = Biz::Order.order(created_at: :desc)

    @customers = Biz::Customer.order(:name).select(:id, :name)
    @users = Sys::User.where(role: Sys::Role.find_by(:name => :staff)).order(:name).select(:id, :name)

    # 1. 客户/员工 过滤
	  query = query.where(customer_id: params[:customer_id]) if params[:customer_id].present?
	  query = query.where(staff_id: params[:staff_id]) if params[:staff_id].present?
	  
	  # 2. 时间范围 过滤
	  query = query.where("created_at >= ?", params[:start_date].to_date.beginning_of_day) if params[:start_date].present?
	  query = query.where("created_at <= ?", params[:end_date].to_date.end_of_day) if params[:end_date].present?

    respond_to do |format|
	    format.html {
	    	@pagy, @orders = pagy(:offset, query, limit: 5)
	    }
	    format.xlsx {
	    	@orders = query
	      # 这里调用你的导出逻辑，比如使用 axlsx_rails
	      response.headers['Content-Disposition'] = 'attachment; filename="订单查询	.xlsx"'
	    }
	  end
  end

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

	def destroy
    if @order.destroy
      redirect_to admin_orders_path
    end
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
