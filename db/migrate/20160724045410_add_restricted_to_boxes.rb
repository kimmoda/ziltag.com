# frozen_string_literal: true
class AddRestrictedToBoxes < ActiveRecord::Migration
  def change
    add_column :boxes, :restricted, :boolean, null: false, default: false
  end
end
