# frozen_string_literal: true
class CorrectPhotosIndex < ActiveRecord::Migration
  def up
    remove_index :photos, :href
    remove_index :photos, :source
    add_index :photos, [:source, :href], unique: true
  end

  def down
    remove_index :photos, [:source, :href]
    add_index :photos, :href, name: 'index_photos_on_href', using: :btree
    add_index :photos, :source, name: 'index_photos_on_source', unique: true, using: :btree
  end
end
