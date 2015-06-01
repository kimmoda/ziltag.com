class AddCollectableToCollectings < ActiveRecord::Migration
  def change
    add_reference :collectings, :collectable, polymorphic: true, index: true
    add_index :collectings, [:user_id, :collectable_id, :collectable_type], unique: true, name: 'index_collectings_on_user_id_and_collectable'
    reversible do |dir|
      Collecting.find_each do |collecting|
        dir.up{ collecting.update_columns collectable_id: collecting.post_id, collectable_type: :Post }
        dir.down{collecting.update_column :post_id, collecting.collectable_id}
      end
      dir.up{ change_column_null :collectings, :collectable_id, false }
      dir.up{ change_column_null :collectings, :collectable_type, false }
      dir.down{
        change_column_null :collectings, :post_id, false
        add_index :collectings, [:user_id, :post_id], unique: true
        add_index :collectings, [:post_id, :user_id], unique: true
      }
    end
    remove_reference :collectings, :post, foreign_key: true
  end
end
