# frozen_string_literal: true
require 'flowdock'
class NotifyFlowdockOfSignUp < Interactor2
  API_TOKEN = 'efec586b1fff5b17e0cb6c477f3a246c'
  DEV_FLOW = '185a6ee8-36fa-4f46-9727-ad4e99076545'

  def initialize(username)
    @username = username
  end

  def perform
    client = Flowdock::Client.new(api_token: API_TOKEN)
    client.chat_message(
      flow: DEV_FLOW,
      content: "新的使用者：#{@username}",
      external_user_name: 'ZiltagRobot',
      tags: ['@David']
    )
  rescue
    Rails.logger.error $!
    Rails.logger.error $@.join
    fail! $!.to_s
  end
end
