# frozen_string_literal: true
class AddHostToBoxes < ActiveRecord::Migration
  def change
    add_column :boxes, :url, :string
    add_index :boxes, :url
  end
end
