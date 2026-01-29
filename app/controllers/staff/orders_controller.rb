# app/controllers/staff/orders_controller.rb
module Staff
  class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_order, only: [:update, :show]

    def approved
    end

    def show
      
    end

    def update
      # 抢单守卫：只有 staff_id 为空，且状态是 submitted 时才能抢
      # 我们不改变 status，只改变 staff_id
      if @order.staff_id.nil? && @order.status == "submitted"
        
        # 抢单：绑定当前员工
        if @order.update(staff: current_user)
          respond_to do |format|
            format.html { redirect_to staff_order_path(@order), notice: "接单成功" }
            format.turbo_stream {
              flash.now[:notice] = "接单成功！"
              render turbo_stream: [
                turbo_stream.prepend("flash_messages", partial: "layout/flash"),
                turbo_stream.action(:redirect, staff_order_path(@order))
              ]
            }
          end
        else
          render_error("系统错误，请重试")
        end
      else
        render_error("手慢了，该订单已被接走或状态已变更")
      end
    end

    private

    def set_order
      @order = Biz::Order.find(params[:id])
    end

    def render_error(message)
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path, alert: message }
        format.turbo_stream {
          flash.now[:alert] = message
          render turbo_stream: turbo_stream.prepend("flash_messages", partial: "layout/flash")
        }
      end
    end
  end
end