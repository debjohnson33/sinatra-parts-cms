class AddPartsManufacturerTable < ActiveRecord::Migration[5.1]
  def change
  	create_table :part_manufacturer do |t|
		t.integer :part_id
		t.integer :manufacturer_id
  	end
  end
end
