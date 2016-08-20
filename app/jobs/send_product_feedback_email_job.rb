# frozen_string_literal: true
class SendProductFeedbackEmailJob < ActiveJob::Base #:nodoc:
  queue_as :default

  def perform(user)
    error = SendProductFeedbackEmail.perform(user).error
    raise error if error
  end
end
