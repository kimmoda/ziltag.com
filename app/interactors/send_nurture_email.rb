# frozen_string_literal: true

class SendNurtureEmail #:nodoc:
  include Interactor
  TEMPLATE_NAME = 'nurture-2'

  def initialize(user)
    @user = user
  end

  def call
    context[:result] = MANDRILL_CLIENT.messages.send_template TEMPLATE_NAME,
                                                              [],
                                                              message
  rescue
    fail! $ERROR_INFO
  end

  def message
    {
      subject: 'Need help installing Ziltag and start tagging?',
      from_email: 'robot@ziltag.com',
      from_name: 'Ziltag Robot',
      to: [{ email: @user.email, name: @user.username }],
      merge_vars: merge_vars
    }
  end

  def merge_vars
    [
      {
        rcpt: @user.email,
        vars: [{ name: '*|FNAME|*', content: @user.username }]
      }
    ]
  end
end
