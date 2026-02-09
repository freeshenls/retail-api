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

  def staff?
    role&.name == "staff"
  end

  def finance?
    role&.name == "finance"
  end

  def designer?
    role&.name == "designer"
  end

  def admin?
    role&.name == "admin"
  end
end
