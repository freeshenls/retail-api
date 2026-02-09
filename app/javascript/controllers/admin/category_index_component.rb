class Admin::CategoryIndexComponent < ViewComponent::Base
  def initialize(categories:, pagy:)
    @categories = categories
    @pagy = pagy
  end
end
