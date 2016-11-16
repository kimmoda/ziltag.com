class AddNamespaceToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :namespace, :string
    add_index :photos, :namespace
  end
end
