class PartManufacturer < ActiveRecord::Base
	belongs_to :part
	belongs_to :manufacturer
end