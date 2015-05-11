class AddImageUrlToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :url, :string
    add_index :photos, :url
    Photo.find_each do |photo|
      photo.update_attribute :url, photo.image_url
    end
  end
end
