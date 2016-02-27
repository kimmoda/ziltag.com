class AddUnsubscribersToZiltags < ActiveRecord::Migration
  def change
    add_column :ziltags, :unsubscribers, :integer, array: true, default: []
    add_index :ziltags, :unsubscribers
  end
end
