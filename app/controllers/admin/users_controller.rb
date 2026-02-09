class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    query = Sys::User.order(created_at: :desc)
    @pagy, @users = pagy(:offset, query, limit: 5)
  end

  def edit
    @roles = Sys::Role.all
  end

  def update
    @user.update(user_params)
    # 成功后跳转回列表，利用 Turbo Frame 局部刷新
    redirect_to admin_users_path, notice: "用户 [#{@user.name}] 资料已更新"
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path
    end
  end

  private
  
  def set_user
    @user = Sys::User.find(params[:id])
  end

  def user_params
    # 根据你的业务需求允许修改的字段
    params.require(:sys_user).permit(:name, :role_id)
  end
end
