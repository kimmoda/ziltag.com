class RemoveUselessTables < ActiveRecord::Migration
  def up
    drop_table :subscribers
    drop_table :taggings
    drop_table :tags
    drop_table :posts
    drop_table :ziltaggings
    drop_table :collectings
    drop_table :followings
    drop_table :students
    drop_table :stickers
    drop_table :libpuzzle_signatures
  end
end
