class CreateZiltaggings < ActiveRecord::Migration
  def change
    create_table :ziltaggings do |t|
      t.references :post, index: true, foreign_key: true
      t.references :photo, index: true, foreign_key: true
      t.integer :x
      t.integer :y

      t.timestamps null: false
    end
  end
end
