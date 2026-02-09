class Admin::UsersController < ApplicationController
  def index
    query = Sys::User.order(created_at: :desc)
    @pagy, @users = pagy(:offset, query, limit: 5)
  end

  def destroy
    @user = Sys::User.find(params[:id])

    if @user.destroy
      redirect_to admin_users_path
    end
  end
end
