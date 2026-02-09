class Admin::CustomerIndexComponent < ViewComponent::Base
  def initialize(customers:, pagy:)
    @customers = customers
    @pagy = pagy
  end
end