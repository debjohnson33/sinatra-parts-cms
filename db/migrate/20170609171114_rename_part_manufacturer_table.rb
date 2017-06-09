class RenamePartManufacturerTable < ActiveRecord::Migration[5.1]
  def change
  	  	rename_table :part_manufacturer, :part_manufacturers
  end
end
