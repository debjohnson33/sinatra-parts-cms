class ChangePartsTable < ActiveRecord::Migration[5.1]
  def change
  	change_table :parts do |t|
		t.remove :manufacturer
		t.integer :manufacturer_id  		
  	end
  end
end
