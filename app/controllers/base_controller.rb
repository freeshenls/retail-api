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

    if profile_params[:password].present?
      if @user.update_with_password(profile_params)
        bypass_sign_in(@user) # 保持登录状态
        redirect_to profile_path, notice: "个人资料更新成功！"
      else
        redirect_to profile_path, alert: "原密码错误或新密码不符合规范！"
      end
    else
      if @user.update_without_password(profile_params.except(:password, :password_confirmation, :current_password))
        redirect_to profile_path, notice: "个人资料更新成功！"
      else
        render :profile, status: :unprocessable_entity
      end
    end
  end

  private

  def profile_params
    params.require(:sys_user).permit(
      :name, 
      :bio, 
      :phone, 
      :avatar, 
      :password, 
      :password_confirmation, 
      :current_password
    )
  end
end
