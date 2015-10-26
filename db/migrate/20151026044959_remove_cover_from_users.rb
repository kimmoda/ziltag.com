class RemoveCoverFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :cover, :string
  end
end
