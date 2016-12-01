class AddNameToShortenUrls < ActiveRecord::Migration
  def change
    add_column :shorten_urls, :display_name, :string
  end
end
