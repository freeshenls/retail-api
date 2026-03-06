# frozen_string_literal: true

class Common::OrderShowComponent < ViewComponent::Base
  renders_one :action

	def initialize(order:)
    @order = order
  end

  def can_accpect?(user:, order:)
    order.submitted? && order.staff.blank? && user.staff?
  end

  def can_approve?(user:, order:)
    order.submitted? && user.staff? && user == order.staff
  end

  def can_print_tag?(user:, order:)
    order.approved? && user.staff? && user == order.staff
  end

  def can_print_task?(user:, order:)
    if user.admin?
      order.approved? || order.received? || order.checked?
    elsif user.staff? && user == order.staff
      order.approved? || order.received? || order.checked?
    elsif user.designer? && order.draft.user == user
      order.received? || order.checked?
    end
  end

  def can_settle?(user:, order:)
    if order.received? || order.checked?
      user.admin? && !order.is_settled
    end
  end
end
