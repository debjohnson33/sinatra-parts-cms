class Manufacturer < ActiveRecord::Base
	has_many :parts
	has_many :user_manufacturers
	has_many :users, through: :user_manufacturers
end