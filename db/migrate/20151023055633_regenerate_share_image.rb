# frozen_string_literal: true
class RegenerateShareImage < ActiveRecord::Migration
  def change
    Ziltag.find_each do |ziltag|
      ziltag.update remote_share_image_url: ziltag.photo.image_url
    end
  end
end
