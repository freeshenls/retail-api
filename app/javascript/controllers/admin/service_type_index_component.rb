class Admin::ServiceTypeIndexComponent < ViewComponent::Base
  def initialize(service_types:, pagy:)
    @service_types = service_types
    @pagy = pagy
  end
end
