# frozen_string_literal: true
class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.string :email, null: false

      t.timestamps null: false
    end
  end
end
