# app/javascript/controllers/admin/invite_index_component.rb
class Admin::InviteIndexComponent < ViewComponent::Base
  def initialize(invite_codes:, roles:, pagy:)
    @invite_codes = invite_codes
    @roles = roles
    @pagy = pagy
    @new_invite_code = Sys::InviteCode.new
  end
end
