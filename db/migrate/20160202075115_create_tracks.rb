class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :event, null: false
      t.string :token, null: false
      t.string :status, null: false, default: 'success'

      t.timestamps null: false
    end
    add_index :tracks, :token
  end
end
