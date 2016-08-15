# frozen_string_literal: true
class AddTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :type, :string
  end
end
