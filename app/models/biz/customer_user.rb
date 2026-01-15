class Biz::CustomerUser < ApplicationRecord

	belongs_to :customer
	belongs_to :user, class_name: "Sys::User"
end
