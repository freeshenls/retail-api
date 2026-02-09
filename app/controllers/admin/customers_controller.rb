# app/controllers/admin/customers_controller.rb
class Admin::CustomersController < ApplicationController
	before_action :set_customer, only: [:edit, :update, :destroy]

  def index
    query = Biz::Customer.order(created_at: :desc)
    @pagy, @customers = pagy(:offset, query, limit: 5)
  end

  def new
  	@customer = Biz::Customer.new
  end

  def create
	  @customer = Biz::Customer.new(customer_params)
	  @customer.save
    redirect_to admin_customers_path, notice: "客户 [#{@customer.name}] 档案登记成功"
	end

	def edit
	end

	def update
	  @customer.update(customer_params)
	  redirect_to admin_customers_path, notice: "客户档案已成功更新"
	end

	def destroy
    @customer.destroy
    redirect_to admin_customers_path, notice: "客户档案已注销" 
  end

	private

	def set_customer
    # 假设您的模型名是 BizCustomer
    @customer = Biz::Customer.find(params[:id])
  end

	def customer_params
	  params.require(:biz_customer).permit(:name, :address, :card_name, :card_no, :credit_limit)
	end
end
