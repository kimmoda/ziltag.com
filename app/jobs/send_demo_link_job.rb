# frozen_string_literal: true
class SendDemoLinkJob < ActiveJob::Base
  queue_as :default

  def perform(email, preview_id)
    error = SendDemoLink.perform(email, preview_id).error
    raise error if error
  end
end
