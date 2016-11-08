class CreateShortenUrls < ActiveRecord::Migration
  def change
    create_table :shorten_urls do |t|
      t.string :url, null: false
      t.string :natural_id, null: false
    end
    add_index :shorten_urls, :url, unique: true
    add_index :shorten_urls, :natural_id, unique: true
  end
end
