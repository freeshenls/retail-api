class Biz::Customer < ApplicationRecord

	has_many :customer_users
	has_many :users, through: :customer_users
end
