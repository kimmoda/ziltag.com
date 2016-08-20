# frozen_string_literal: true
class RemoveUselessTables < ActiveRecord::Migration
  def up
    drop_table :subscribers
    drop_table :taggings
    drop_table :tags
    drop_table :posts
    drop_table :ziltaggings
    drop_table :collectings
    drop_table :followings
  end
end
