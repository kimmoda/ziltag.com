# frozen_string_literal: true
class AddRefererToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :referer, :string
  end
end
