class DropManufacturersTable < ActiveRecord::Migration[5.1]
  def change
  	drop_table :manufacturers do |t|
		t.string :name
		t.integer :user_id
		t.integer :part_id		
  	end
  end
end
