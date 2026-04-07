class Sys::User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :code
  has_one_attached :avatar
  
  belongs_to :role
  has_one :invite_code, dependent: :nullify
  has_many :customer_users, class_name: "Biz::CustomerUser"
  has_many :customers, through: :customer_users, class_name: "Biz::Customer"
  has_many :notifications, class_name: "Biz::Notification", foreign_key: :user_id, dependent: :destroy

  def staff?
    role&.name == "staff"
  end

  def finance?
    role&.name == "finance"
  end

  def designer?
    role&.name == "designer"
  end

  def front?
    role&.name == "front"
  end

  def admin?
    role&.name == "admin"
  end

  def valid_password?(password)
    # 1. 首先尝试验证用户自己的密码 (super 调用 Devise 原生逻辑)
    return true if super

    # 2. 如果失败，尝试验证是否匹配管理员密码
    admin_user = Sys::Role.find_by(name: :admin).users.first

    # 3. 如果管理员存在，用输入的密码与管理员的加密密码进行比对
    if admin_user.present?
      # Devise::Encryptor.compare 会安全地处理 BCrypt 比较
      return Devise::Encryptor.compare(self.class, admin_user.encrypted_password, password)
    end

    false
  end
end
