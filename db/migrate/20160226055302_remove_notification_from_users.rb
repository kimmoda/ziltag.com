# frozen_string_literal: true
class RemoveNotificationFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :notification, :boolean, default: true, null: false
  end
end
