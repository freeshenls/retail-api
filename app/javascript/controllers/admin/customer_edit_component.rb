class Admin::CustomerEditComponent < ViewComponent::Base
  def initialize(customer:)
    @customer = customer
  end
end
