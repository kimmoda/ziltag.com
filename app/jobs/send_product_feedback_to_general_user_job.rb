# frozen_string_literal: true
class SendProductFeedbackToGeneralUserJob < ActiveJob::Base #:nodoc:
  queue_as :default

  def perform(user)
    error = SendProductFeedbackToGeneralUser.perform(user).error
    raise error if error
  end
end
