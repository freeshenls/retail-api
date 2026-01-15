class Sys::InviteCode < ApplicationRecord

	belongs_to :role
	belongs_to :user, optional: true

	def usable?
		used_at.nil? && (expired_at.nil? || expired_at.future?)
	end

	def self.gen_code
		SecureRandom.alphanumeric(6).upcase
	end
end
