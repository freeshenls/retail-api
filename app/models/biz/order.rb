# app/models/biz/order.rb
class Biz::Order < ApplicationRecord
  attribute :status, :string

  belongs_to :unit, class_name: "Biz::Unit", optional: true
  belongs_to :customer, class_name: "Biz::Customer", optional: true
  belongs_to :draft, class_name: "Biz::Draft", foreign_key: "draft_id"

  enum :status, { 
      pending: "pending",     # 待处理
      submitted: "submitted", # 已提交(待审核)
      approved: "approved",   # 审核通过
      rejected: "rejected"    # 已退回
    }, default: :pending

  
  before_save :set_total_amount
  before_validation :sync_names_from_associations
  before_validation :assign_order_no, on: :create

  private

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

  def assign_order_no
    return if order_no.present?
    
    # 只需要调用 Sequence 的方法即可
    self.order_no = Biz::Sequence.generate_next_no
  end
end
