class Admin::UserIndexComponent < ViewComponent::Base
  def initialize(users:, pagy:)
    @users = users
    @pagy = pagy
  end
end
