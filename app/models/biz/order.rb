# app/models/biz/order.rb
class Biz::Order < ApplicationRecord
  attribute :status, :string

  belongs_to :staff, class_name: "Sys::User", optional: true
  belongs_to :unit, class_name: "Biz::Unit", optional: true
  belongs_to :customer, class_name: "Biz::Customer", optional: true
  belongs_to :draft, class_name: "Biz::Draft", foreign_key: "draft_id"
  accepts_nested_attributes_for :draft
  after_commit :broadcast_submitted_notifications, on: [:create, :update]
  after_update_commit :broadcast_designer_notifications

  scope :for_staff, ->(user) { where(staff_id: user.id ) }
  scope :for_designer, ->(user) { joins(:draft).where(biz_draft: { user_id: user.id }) }
  scope :for_finance, ->(user) { joins(draft: { user: :customers }).where(biz_customer: { id: user.customer_ids }).distinct}

  enum :status, { 
      pending: "pending",     # 待处理
      submitted: "submitted", # 已提交(待发货)
      approved: "approved",   # 核实并发货
      rejected: "rejected",   # 已退回
      received: "received",    # 已收货
      checked: "checked"      # 财务已核实
    }, default: :pending
  
  before_save :set_total_amount
  before_save :calculate_amount
  before_validation :sync_names_from_associations

  def broadcast_designer_notifications
    target_user = draft&.user
    return unless target_user

    approved_orders = Biz::Order.joins(:draft)
                                .where(biz_draft: { user_id: target_user.id })
                                .where(status: :approved, is_settled: false)
                                .order(updated_at: :desc)

    # 广播：直接替换掉 ID 为 "notification_wrapper" 的整个容器
    broadcast_replace_to "notifications_user_#{target_user.id}",
      target: "notification_wrapper",
      partial: "designer/notification",
      locals: { 
        orders: approved_orders, 
        notifications: Biz::Notification.unread(self.draft.user)
      }
  end

  def broadcast_submitted_notifications
    # 只有当状态变为 submitted 且还没有分配员工时，才触发抢单广播
    return unless status == "submitted" && staff_id.nil?

    # 获取所有待抢订单（已提交且未结算/未接单）
    submitted_orders = Biz::Order.where(status: :submitted, staff_id: nil)
                                 .order(updated_at: :desc)

    # 广播给所有订阅了 "staff_notifications" 的员工
    broadcast_replace_to "staff_notifications",
      target: "submitted_notification_wrapper", # 对应 Navbar 铃铛的 ID
      partial: "staff/orders/submitted_notification",
      locals: { 
        orders: submitted_orders, 
        count: submitted_orders.count,
        play_sound: true
      }
  end

  private

  def calculate_amount
    self.amount = (quantity.to_f * unit_price.to_f) + delivery_fee.to_f
  end

  def sync_names_from_associations
    # 同步客户名称
    self.customer_name = customer.name if customer_id_changed? && customer.present?
    
    # 同步稿件名称
    self.draft_name = draft.name if draft_id_changed? && draft.present?
    
    # 同步规格名称 (如果 unit 存在)
    if unit_id_changed? && unit.present?
      self.category_name = unit.category&.name
      self.service_type = unit.service_type
    end
  end

  def set_total_amount
    # 确保计算时是数值
    q = quantity.to_f
    p = unit_price.to_f
    f = delivery_fee.to_f
    self.amount = (q * p) + f
  end
end
