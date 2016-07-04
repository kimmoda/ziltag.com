# frozen_string_literal: true

class SendWelcomeEmail #:nodoc:
  include Interactor

  def initialize(user)
    @user = user
  end

  def call
    context[:result] = MANDRILL_CLIENT.messages.send_template template_name,
                                                              [],
                                                              message
  rescue
    fail! $ERROR_INFO
  end

  def template_name
    if @user.content_provider?
      'welcome-email-partner'
    else
      'welcome-email-normal-user'
    end
  end

  def message
    {
      subject: 'Welcome to Ziltag - just one more step!',
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
        vars: [
          { name: 'FNAME', content: @user.username },
          { name: 'CONFIRM_URL', content: "https://#{Rails.configuration.action_mailer.default_url_options[:host]}/dashboard/verify?confirmation_token=#{URI.encode_www_form_component(@user.confirmation_token)}" }
        ]
      }
    ]
  end
end
