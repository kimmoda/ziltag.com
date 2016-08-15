# frozen_string_literal: true
class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :tag, index: true, foreign_key: true
      t.references :taggable, polymorphic: true, index: true

      t.timestamps null: false
    end
    add_index :taggings, [:tag_id, :taggable_id, :taggable_type], unique: true
  end
end
