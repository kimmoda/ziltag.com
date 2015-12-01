class AddGeoToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :width, :integer, default: 0
    add_column :photos, :height, :integer, default: 0
    Photo.find_each do |photo|
      begin
        photo.image.cache_stored_file!
        width, height = ::MiniMagick::Image.open(photo.image.file.file)[:dimensions]
        photo.update_columns width: width, height: height
      rescue
        Rails.logger.warn "[migration] broken photo: #{photo.id}"
      end
    end
    change_column_null :photos, :width, false
    change_column_null :photos, :height, false
  end
end
