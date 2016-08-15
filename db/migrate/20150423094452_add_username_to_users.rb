# frozen_string_literal: true
class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    User.find_each do |user|
      username = user.email[/^(\w+)@/, 1]
      username = SecureRandom.hex(3) while User.exists?(username: username)
      user.update_attribute :username, username
    end
    change_column_null :users, :username, false
    add_index :users, :username, unique: true
  end
end
