class AddGeoToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :width, :integer
    add_column :photos, :height, :integer
    Photo.find_each do |photo|
       photo.image.cache_stored_file!
       width, height = ::MiniMagick::Image.open(photo.image.file.file)[:dimensions]
       photo.update_columns width: width, height: height
    end
    change_column_null :photos, :width, false
    change_column_null :photos, :height, false
  end
end
