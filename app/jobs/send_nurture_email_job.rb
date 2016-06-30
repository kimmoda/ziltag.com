# frozen_string_literal: true
class SendNurtureEmailJob < ActiveJob::Base #:nodoc:
  queue_as :default

  def perform(user)
    unless user.has_created_first_ziltag
      error = SendNurtureEmail.call(user).context[:error]
      raise error if error
    end
  end
end
