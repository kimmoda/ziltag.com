class AddRefererToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :referer, :string
  end
end
