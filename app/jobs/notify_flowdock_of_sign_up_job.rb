class NotifyFlowdockOfSignUpJob < ActiveJob::Base
  queue_as :default

  def perform(user)
    result = NotifyFlowdockOfSignUp.perform(user)
    raise result.error if result.error
  end
end
