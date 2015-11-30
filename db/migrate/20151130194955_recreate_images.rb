class RecreateImages < ActiveRecord::Migration
  def change
    Photo.find_each do |photo|
      photo.image.try(:recreate_versions!)
    end
  end
end
