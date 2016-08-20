# frozen_string_literal: true
class RedesignZiltagings < ActiveRecord::Migration
  def change
    change_table :ziltaggings do |t|
      t.remove_references :photo, index: true, foreign_key: true, null: false
      t.string :image_url, null: false, index: true
      t.index :image_url
    end
  end
end
