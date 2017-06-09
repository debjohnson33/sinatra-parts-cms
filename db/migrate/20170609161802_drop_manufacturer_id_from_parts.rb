class DropManufacturerIdFromParts < ActiveRecord::Migration[5.1]
  def change
  	remove_column :parts, :manufacturer_id
  end
end
