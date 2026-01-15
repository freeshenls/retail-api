class Admin::UsersController < ApplicationController
  def index
    @users = Sys::User.all
  end
end
