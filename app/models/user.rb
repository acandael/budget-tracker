class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :budgets, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :password, length: { minimum: 8 }, on: :create
end
