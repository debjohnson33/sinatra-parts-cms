class CreateUserManufacturers < ActiveRecord::Migration[5.1]
  def change
  	create_table :user_manufacturers do |t|
		t.integer :user_id
		t.integer :manufacturer_id		
  	end
  end
end
