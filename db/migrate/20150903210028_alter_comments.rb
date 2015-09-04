class AlterComments < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        Comment.destroy_all
      end
      dir.down do
        add_index :comments, :email
        add_foreign_key :comments, :comments
        add_foreign_key :comments, :photos
      end
    end
    rename_column :comments, :text, :content
    remove_column :comments, :email, :string, null: false, index: true
    remove_column :comments, :x, :integer, null: false
    remove_column :comments, :y, :integer, null: false
    remove_reference :comments, :comment, index: true
    remove_reference :comments, :photo, index: true, null: false
    change_column_null :comments, :user_id, false
    add_reference :comments, :sticker, index: true, foreign_key: true, null: false
  end
end
