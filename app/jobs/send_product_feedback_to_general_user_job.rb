# frozen_string_literal: true
class SendProductFeedbackToGeneralUserJob < ActiveJob::Base #:nodoc:
  queue_as :default

  def perform(user)
    error = SendProductFeedbackToGeneralUser.call(user).context[:error]
    raise error if error
  end
end
