# frozen_string_literal: true
class ChangeMailchimpRoleJob < ActiveJob::Base
  queue_as :default

  def perform(user, role)
    error = ChangeMailchimpRole.perform(user, role).error
    raise error if error
  end
end
