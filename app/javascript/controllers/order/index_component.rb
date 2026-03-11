# frozen_string_literal: true

class Order::IndexComponent < ViewComponent::Base
	renders_one :query
  renders_one :table
  renders_one :pagy

  def initialize
  end
end
