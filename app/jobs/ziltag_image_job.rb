# frozen_string_literal: true
class ZiltagImageJob < ActiveJob::Base
  queue_as :default

  def perform(ziltag)
    ziltag.update! remote_share_image_url: ziltag.photo.image_url
  end
end
