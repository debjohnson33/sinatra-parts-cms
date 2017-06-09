class DropPartManufacturersTable < ActiveRecord::Migration[5.1]
  def change
  	drop_table :part_manufacturers do |t|
		t.integer :part_id
		t.integer :manufacturer_id
  	end
  end
end
