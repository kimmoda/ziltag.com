# frozen_string_literal: true

class SendNurtureEmail < Interactor2 #:nodoc:
  TEMPLATE_NAME = 'nurture-2'
  attr_reader :result

  def initialize(user)
    @user = user
  end

  def perform
    @result = MANDRILL_CLIENT.messages.send_template TEMPLATE_NAME,
                                                     [],
                                                     message
  rescue
    fail! $ERROR_INFO
  end

  def message
    {
      subject: 'Need help installing Ziltag and start tagging?',
      from_email: 'david@ziltag.com',
      from_name: 'David Chang',
      to: [{ email: @user.email, name: @user.username }],
      merge_vars: merge_vars
    }
  end

  def merge_vars
    [
      {
        rcpt: @user.email,
        vars: [{ name: 'FNAME', content: @user.username }]
      }
    ]
  end
end
