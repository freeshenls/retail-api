class Admin::UserEditComponent < ViewComponent::Base
  def initialize(user:, roles:)
    @user = user
    @roles = roles
  end
end
