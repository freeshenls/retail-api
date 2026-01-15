class Admin::InviteIndexComponent < ViewComponent::Base
  def initialize(invite_codes:, roles:)
    @invite_codes = invite_codes
    @roles = roles
    @new_invite_code = Sys::InviteCode.new
  end
end
