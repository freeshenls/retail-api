# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    code = params.dig(:user, :code)
    @invite = Sys::InviteCode.find_by(code: code)

    # 1. 拦截逻辑：校验邀请码是否存在以及是否被占用
    if @invite.user.present?
      @invite.role_id = nil
    end

    super do |resource|
      # 如果注册成功，可以标记邀请码已被使用（如果你的业务需要）
      @invite.update(used_at: Time.new, user: resource) if resource.persisted?
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def sign_up_params
    devise_params = super
    devise_params.merge(role_id: @invite.role_id) if @invite
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :code])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  # Signs in a user on sign up.
  def sign_up(resource_name, resource)
    # sign_in(resource_name, resource)
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    new_user_session_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
