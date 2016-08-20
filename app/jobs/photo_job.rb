# frozen_string_literal: true
class PhotoJob < ActiveJob::Base
  queue_as :default

  def perform(photo, url)
    photo.update! remote_image_url: url
  rescue ActiveRecord::RecordInvalid
    logger.info $ERROR_INFO
    photo.destroy
    logger.info "Photo ##{photo.id} with URL #{url} has been destroyed."
  end

  after_perform do |job|
    photo, url = job.arguments
    photo.ziltags(true).each do |ziltag|
      ziltag.generate_share_image_later unless ziltag.share_image?
    end
  end
end
