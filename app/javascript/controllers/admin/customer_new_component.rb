class Admin::CustomerNewComponent < ViewComponent::Base
  def initialize(customer:)
    @customer = customer
  end
end
