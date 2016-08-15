# frozen_string_literal: true
class CreateCollectings < ActiveRecord::Migration
  def change
    create_table :collectings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.index([:user_id, :post_id], unique: true)
      t.index([:post_id, :user_id], unique: true)
      t.timestamps null: false
    end
  end
end
