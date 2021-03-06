# frozen_string_literal: true
class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.string :title
      t.string :image, null: false

      t.timestamps null: false
    end
  end
end
