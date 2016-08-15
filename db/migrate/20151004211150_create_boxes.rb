# frozen_string_literal: true
class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.string :token, null: false
      t.references :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
    add_index :boxes, :token, unique: true
  end
end
