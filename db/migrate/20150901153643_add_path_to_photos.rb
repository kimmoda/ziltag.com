class AddPathToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :path, :string
    add_index :photos, :path
  end
end
