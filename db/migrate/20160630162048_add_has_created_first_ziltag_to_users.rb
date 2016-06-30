class AddHasCreatedFirstZiltagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_created_first_ziltag, :boolean, default: false
    reversible do |dir|
      dir.up do
        User.joins(:ziltags).uniq.update_all(has_created_first_ziltag: true)
      end
    end
  end
end
