# frozen_string_literal: true
class SendCommentNotificationJob < ActiveJob::Base # :nodoc
  queue_as :default

  def perform(comment)
    error = SendCommentNotification.call(comment).context[:error]
    raise error if error
  end
end
