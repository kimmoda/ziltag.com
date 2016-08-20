# frozen_string_literal: true

class SubscribeNewsletterJob < ActiveJob::Base
  queue_as :default

  def perform(user)
    error = SubscribeNewsletter.perform(user).error
    raise error if error
  end
end
