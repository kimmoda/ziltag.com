class RenameBoxToWebsite < ActiveRecord::Migration
  def change
    rename_table :boxes, :websites
    rename_column :photos, :box_id, :website_id
  end
end
