# frozen_string_literal: true
require 'flowdock'
class NotifyFlowdockOfZiltag < Interactor2
  API_TOKEN = 'efec586b1fff5b17e0cb6c477f3a246c'
  FLOW_ID = '2c9eff05-f00e-4444-9384-aa79b29ec266'

  def initialize(ziltag)
    @ziltag = ziltag
  end

  def perform
    client = Flowdock::Client.new(api_token: API_TOKEN)
    client.chat_message(
      flow: FLOW_ID,
      content: content,
      external_user_name: 'ZiltagRobot',
      tags: ['@team']
    )
  rescue
    Rails.logger.error $ERROR_INFO
    Rails.logger.error $ERROR_POSITION.join
    fail! $ERROR_INFO.to_s
  end

  def content
    @content ||= <<~EOS
      == New Ziltag ==
      author: #{@ziltag.user&.username}
      website: #{@ziltag.photo&.href}
      reader: #{ziltag_url}
      content: #{@ziltag.content}
    EOS
  end

  private

  def host
    @host ||= "https://#{Rails.env.production? ? Settings.host : 'ziltag.dev'}"
  end

  def ziltag_url
    @ziltag_url ||= "#{host}/ziltags/#{@ziltag.natural_id}"
  end
end
