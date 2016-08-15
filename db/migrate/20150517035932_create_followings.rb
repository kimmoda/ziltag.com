# frozen_string_literal: true
class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.integer :follower_id, null: false
      t.integer :leader_id, null: false
      t.index([:follower_id, :leader_id], unique: true)
      t.index([:leader_id, :follower_id], unique: true)

      t.timestamps null: false
    end
    add_foreign_key :followings, :users, column: :follower_id
    add_foreign_key :followings, :users, column: :leader_id
  end
end
