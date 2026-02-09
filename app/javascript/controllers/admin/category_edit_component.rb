class Admin::CategoryEditComponent < ViewComponent::Base
  def initialize(category:)
    @category = category
  end
end
