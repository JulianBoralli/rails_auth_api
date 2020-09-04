class User < ApplicationRecord
  has_secure_token :auth_token
  has_secure_password

  validates :password, confirmation: true
	validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of :email
  validates_uniqueness_of :email
  validates :email, format: { with: /\A[^@\s]+@([^@\s.]+\.)+[^@\W]+\z/ }
end
