class Sys::Role < ApplicationRecord
  has_many :users

  scope :sign_roles, -> { where(name: ['staff', 'finance', 'designer']).order(:name) }
end
