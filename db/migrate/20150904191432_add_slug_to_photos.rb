class AddSlugToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :slug, :string
    add_index :photos, :slug

    reversible do |dir|
      dir.up do
        Photo.find_each do |photo|
          photo.generate_slug if photo.slug.blank?
          photo.save!
        end
      end
    end

    change_column_null :photos, :slug, false

  end
end
