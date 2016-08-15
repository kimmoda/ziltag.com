# frozen_string_literal: true
class RedesignComments < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.remove_references :commentable, polymorphic: true, index: true, null: false
      t.remove_references :user, index: true, foreign_key: true, null: false

      t.string :text, :image_url, :email, null: false
      t.index :image_url
      t.index :email

      t.integer :x, null: false
      t.integer :y, null: false

      t.references :comment, foreign_key: true, index: true
    end
  end
end
