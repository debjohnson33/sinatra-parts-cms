class CreateParts < ActiveRecord::Migration[5.1]
  def change
  		create_table :parts do |t|
			t.string :name
		    t.string :serial_number
		    t.integer :quantity
		    t.integer :user_id
		    t.string :manufacturer_id  			
  		end
  end
end
