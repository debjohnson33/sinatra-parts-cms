class User < ActiveRecord::Base
	has_secure_password
	has_many :parts
	has_many :part_manufacturers
	has_many :manufacturers, through: :part_manufacturers
end