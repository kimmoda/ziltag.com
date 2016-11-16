class RemoveUrlIndexFromShortenUrls < ActiveRecord::Migration
  def change
    remove_index :shorten_urls, column: :url, unique: true
  end
end
