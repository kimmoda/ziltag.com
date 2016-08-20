# frozen_string_literal: true
class AddNotificationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notification, :boolean, null: false, default: true
  end
end
