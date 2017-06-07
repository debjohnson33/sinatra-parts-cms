class CreateParts < ActiveRecord::Migration[5.1]
  def change
  	create_table :parts do |t|
		t.string :name
		t.integer :quantity
		t.integer :user_id
  	end
  end
end
