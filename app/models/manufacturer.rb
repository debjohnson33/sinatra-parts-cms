class Manufacturer < ActiveRecord::Base
	belongs_to :user
	belongs_to :parts
end