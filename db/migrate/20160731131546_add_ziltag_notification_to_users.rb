class AddZiltagNotificationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ziltag_notification, :boolean, null: false, default: true
    add_column :users, :comment_notification, :boolean, null: false, default: true
  end
end
