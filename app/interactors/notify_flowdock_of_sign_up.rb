# frozen_string_literal: true
require 'flowdock'
class NotifyFlowdockOfSignUp < Interactor2
  API_TOKEN = 'efec586b1fff5b17e0cb6c477f3a246c'
  FLOW_ID = '2c9eff05-f00e-4444-9384-aa79b29ec266'

  def initialize(user)
    @user = user
    @website = user.website
  end

  def perform
    client = Flowdock::Client.new(api_token: API_TOKEN)
    client.chat_message(
      flow: FLOW_ID,
      content: content,
      external_user_name: 'ZiltagRobot',
      tags: ['@David']
    )
  rescue
    Rails.logger.error $ERROR_INFO
    Rails.logger.error $ERROR_POSITION.join
    fail! $ERROR_INFO.to_s
  end

  def content
    <<~EOS
    new partner：#{@user.username}
    email: #{@user.email}
    url: #{@website.url}
    token: #{@website.token}
    EOS
  end
end
