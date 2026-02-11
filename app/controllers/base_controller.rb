class BaseController < ApplicationController
	def profile
    @user = current_user
  end

  def mark_as_read
    @notification = current_user.notifications.find(params[:id])

    @notification.mark_as_read!

    @order = @notification.target
    @order.broadcast_designer_notifications
  end

  def profile_update
    @user = current_user
    if @user.update(profile_params)
      redirect_to profile_path, notice: "个人资料更新成功！"
    else
      # 如果失败，重新渲染 profile 页面，此时 Designer::ProfileComponent 会显示错误
      render :profile, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    # 这里的 :sys_user 需对应你组件中 form_with 传入的 model 键名
    params.require(:sys_user).permit(:name, :bio, :phone, :avatar)
  end
end
