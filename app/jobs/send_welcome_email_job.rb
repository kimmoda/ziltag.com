# frozen_string_literal: true
class SendWelcomeEmailJob < ActiveJob::Base #:nodoc:
  queue_as :default

  def perform(user)
    error = SendWelcomeEmail.call(user).context[:error]
    raise error if error
  end
end
