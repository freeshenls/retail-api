class Biz::Customer < ApplicationRecord

	has_many :customer_users, dependent: :destroy
	has_many :users, through: :customer_users

	has_many :orders, dependent: :destroy
end
