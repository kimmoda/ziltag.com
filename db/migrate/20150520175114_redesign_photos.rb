class RedesignPhotos < ActiveRecord::Migration
  def change
    change_column_null :photos, :user_id, true
    add_column :photos, :source, :string
    add_index :photos, :source, unique: true
    add_reference :ziltaggings, :photo, index: true, foreign_key: true
    add_reference :comments, :photo, index: true, foreign_key: true

    Photo.find_each{ |photo| photo.update_column :source, photo.read_attribute_before_type_cast(:url) }
    Ziltagging.find_each{ |ziltagging| ziltagging.update_column :photo_id, Photo.find_by!(url: ziltagging.read_attribute_before_type_cast(:image_url)).id }
    Comment.find_each { |comment| comment.update_column :photo_id, Photo.find_by!(url: comment.read_attribute_before_type_cast(:image_url)).id }

    change_column_null :ziltaggings, :photo_id, false
    change_column_null :comments, :photo_id, false
    remove_column :photos, :title, :string
    remove_column :photos, :url, :string
    remove_column :ziltaggings, :image_url, :string, null: false
    remove_column :comments, :image_url, :string, null: false
  end

end
