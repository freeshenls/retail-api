# app/controllers/admin/invites_controller.rb
class Admin::InvitesController < ApplicationController
  def index
    @roles = Sys::Role.all
    # 使用 pagy 获取分页数据，每页 5 条
    query = Sys::InviteCode.order(created_at: :desc)
    @pagy, @invites = pagy(:offset, query, limit: 5)
  end

  def create
    @invite_code = Sys::InviteCode.new(invite_params)
    @invite_code.code = Sys::InviteCode.gen_code #
    
    @invite_code.save
    redirect_to admin_invites_path, notice: "邀请码 #{@invite_code.code} 已成功生成"
  end

  private

  def invite_params
    # 严格匹配 Sys::InviteCode 产生的参数名
    params.require(:sys_invite_code).permit(:role_id)
  end
end
