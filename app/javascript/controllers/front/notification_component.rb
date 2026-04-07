# frozen_string_literal: true

class Front::NotificationComponent < ViewComponent::Base

	def initialize(orders:, notifications:)
    @orders = orders
    @notifications = notifications
    @count = orders.count + notifications.count
  end
end
