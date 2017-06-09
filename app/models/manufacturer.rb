class Manufacturer < ActiveRecord::Base
	has_many :parts
	has_many :users, through: :parts
end