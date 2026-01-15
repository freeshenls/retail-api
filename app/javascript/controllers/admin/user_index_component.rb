class Admin::UserIndexComponent < ViewComponent::Base
  def initialize(users:)
    @users = users
  end
end
