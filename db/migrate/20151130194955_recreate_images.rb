# frozen_string_literal: true
class RecreateImages < ActiveRecord::Migration
  def change
    Photo.find_each do |photo|
      begin
        photo.image.recreate_versions! if photo.image?
      rescue
        nil
      end
    end
  end
end
