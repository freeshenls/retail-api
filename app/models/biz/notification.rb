# app/models/biz/notification.rb
class Biz::Notification < ApplicationRecord
  belongs_to :user, class_name: "Sys::User"
  belongs_to :actor, polymorphic: true
  belongs_to :target, polymorphic: true

  # 默认按创建时间倒序排列
  default_scope { order(created_at: :desc) }

  # 常用作用域
  scope :unread, ->(user) { where(user: user).where(read_at: nil) }

  # 业务方法
  def unread?
    read_at.nil?
  end

  def mark_as_read!
    update(read_at: Time.current) if unread?
  end
end
