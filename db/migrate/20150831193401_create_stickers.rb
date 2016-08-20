# frozen_string_literal: true
class CreateStickers < ActiveRecord::Migration
  def change
    create_table :stickers do |t|
      t.references :photo, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :x, null: false
      t.integer :y, null: false
      t.text :content, null: false

      t.timestamps null: false
    end
  end
end
