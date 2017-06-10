class Manufacturer < ActiveRecord::Base
	has_many :parts
	has_many :user_manufacturers
	has_many :user, through: :user_manufacturers
end