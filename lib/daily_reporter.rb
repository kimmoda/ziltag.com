# frozen_string_literal: true
require 'flowdock'
class DailyReporter
  API_TOKEN = 'efec586b1fff5b17e0cb6c477f3a246c'
  FLOW_ID = '2c9eff05-f00e-4444-9384-aa79b29ec266'

  def initialize(time)
    @time = time
    @client = Flowdock::Client.new(api_token: API_TOKEN)
  end

  def report!
    @client.chat_message(
      flow: FLOW_ID,
      content: content,
      external_user_name: 'ZiltagRobot',
      tags: ['@team']
    )
  end

  def content
    <<~EOS
      Daily Report from #{@time.ago 1.day} to #{@time}:

      Unique Visiters: #{unique_visiters}

      Installed Websites (URL, Request Counts):
      #{installed_websites}

      Referers (URL, Request Counts):
      #{referers}
    EOS
  end

  private

  def unique_visiters
    HTTPRequest.number_of_unique_visiters(@time)
  end

  def installed_websites
    result = String.new
    HTTPRequest.active_websites(@time)
               .each { |url, count| result << "#{url}, #{count}\n" }
    result
  end

  def referers
    result = String.new
    HTTPRequest.referers(@time)
               .each { |url, count| result << "#{url}, #{count}\n" }
    result
  end
end
