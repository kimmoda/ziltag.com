# frozen_string_literal: true
class AllowUsernameNil < ActiveRecord::Migration
  def change
    change_column_null :users, :username, true
  end
end
