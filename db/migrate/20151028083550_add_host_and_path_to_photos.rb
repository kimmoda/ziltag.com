class AddHostAndPathToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :host, :string
    add_index :photos, :host
    add_column :photos, :path, :string
    add_index :photos, :path
    Photo.where('href IS NOT NULL').find_each do |photo|
      photo.update! href: photo.href if photo.href?
    end
  end
end
