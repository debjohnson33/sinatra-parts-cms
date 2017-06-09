class DropManufacturerTable < ActiveRecord::Migration[5.1]
  def change
  	drop_table :manufacturers do |t|
		t.string :name
  	end
  end
end
