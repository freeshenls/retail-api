# frozen_string_literal: true

class Admin::RoleIndexComponent < ViewComponent::Base
  def initialize(roles:)
    @roles = roles
  end
end
