# frozen_string_literal: true
class CreateZiltaggings < ActiveRecord::Migration
  def change
    create_table :ziltaggings do |t|
      t.references :post, index: true, foreign_key: true, null: false
      t.references :photo, index: true, foreign_key: true, null: false
      t.integer :x, null: false
      t.integer :y, null: false

      t.timestamps null: false
    end
  end
end
