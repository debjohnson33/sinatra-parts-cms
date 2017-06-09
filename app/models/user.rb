class User < ActiveRecord::Base
	has_secure_password
	has_many :parts
	has_many :manufacturers, through: :parts
end