# frozen_string_literal: true
class AddUserAgentToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :user_agent, :string
  end
end
