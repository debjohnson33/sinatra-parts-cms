class User < ActiveRecord::Base

	has_many :parts
	has_many :user_manufacturers
	has_many :manufacturers, through: :user_manufacturers


	has_secure_password
end