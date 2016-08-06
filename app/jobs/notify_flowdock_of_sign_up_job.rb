class NotifyFlowdockOfSignUpJob < ActiveJob::Base
  queue_as :default

  def perform(username)
    result = NotifyFlowdockOfSignUp.perform(username)
    raise result.error if result.error
  end
end
