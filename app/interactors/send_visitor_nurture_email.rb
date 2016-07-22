# frozen_string_literal: true

class SendVisitorNurtureEmail #:nodoc:
  include Interactor
  TEMPLATE_NAME = 'nurture-1'

  def initialize(visitors = [])
    @visitors = Array(visitors)
  end

  def call
    context[:result] = MANDRILL_CLIENT.messages.send_template TEMPLATE_NAME,
                                                              [],
                                                              message,
                                                              false,
                                                              nil,
                                                              2.days.from_now
  rescue
    fail! $ERROR_INFO
  end

  def message
    {
      subject: 'Need help understanding Ziltag and get started?',
      from_email: 'robot@ziltag.com',
      from_name: 'Ziltag Robot',
      to: to,
      merge_vars: merge_vars
    }
  end

  def to
    @visitors.map do |visitor|
      { email: visitor['email'], name: visitor['name'] }
    end
  end

  def merge_vars
    @visitors.map do |visitor|
      {
        rcpt: visitor['email'],
        vars: [{ name: 'USERNAME', content: visitor['name'] }]
      }
    end
  end
end