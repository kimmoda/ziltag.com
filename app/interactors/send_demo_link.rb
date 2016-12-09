# frozen_string_literal: true

class SendDemoLink < Interactor2 #:nodoc:
  attr_reader :result

  def initialize(user_email, preview_id)
    @user_email = user_email
    @preview_id = preview_id
  end

  def perform
    @result = MANDRILL_CLIENT.messages.send_template 'send-demo-link-email',
                                                     [],
                                                     message
  rescue
    fail! $ERROR_INFO
  end

  def message
    {
      subject: 'Welcome to Ziltag - Your Ziltag Demo is Here.',
      from_email: 'robot@ziltag.com',
      from_name: 'Ziltag',
      to: [{ email: @user_email }],
      merge_vars: merge_vars
    }
  end

  def merge_vars
    [
      {
        rcpt: @user_email,
        vars: [
          { name: 'DEMO_URL', content: demo_url }
        ]
      }
    ]
  end

  def demo_url
    "#{host}/preview/#{@preview_id}"
  end

  def host
    "https://#{Rails.configuration.action_mailer.default_url_options[:host]}"
  end
end
