class Admin::ServiceTypeEditComponent < ViewComponent::Base
  def initialize(service_type:)
    @service_type = service_type
  end
end
