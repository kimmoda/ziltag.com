# frozen_string_literal: true
class AddCoverToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cover, :string
  end
end
