class NotifyFlowdockOfZiltagJob < ActiveJob::Base
  queue_as :default

  def perform(ziltag)
    result = NotifyFlowdockOfZiltag.perform(ziltag)
    raise result.error if result.error
  end
end
