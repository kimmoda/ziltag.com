# frozen_string_literal: true
class ChangeMailchimpRoleJob < ActiveJob::Base
  queue_as :default

  def perform(user, role)
    error = ChangeMailchimpRole.call(user, role).context[:error]
    raise error if error
  end
end
