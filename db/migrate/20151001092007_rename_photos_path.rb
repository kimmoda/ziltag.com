class RenamePhotosPath < ActiveRecord::Migration
  def change
    rename_column :photos, :path, :href
  end
end
