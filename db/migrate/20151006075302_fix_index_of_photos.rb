class FixIndexOfPhotos < ActiveRecord::Migration
  def up
    remove_index :photos, [:source, :href]
    add_index :photos, [:source, :href, :box_id], unique: true
  end

  def down
    add_index :photos, [:source, :href], unique: true
  end
end
