# frozen_string_literal: true
class SendZiltagNotificationJob < ActiveJob::Base #:nodoc:
  queue_as :default

  def perform(ziltag)
    error = SendZiltagNotification.call(ziltag).context[:error]
    raise error if error
  end
end
