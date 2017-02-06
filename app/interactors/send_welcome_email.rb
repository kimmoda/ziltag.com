# frozen_string_literal: true

class SendWelcomeEmail < Interactor2 #:nodoc:
  attr_reader :result

  def initialize(user)
    @user = user
    @website = user.website
  end

  def perform
    @result = MANDRILL_CLIENT.messages.send_template template_name,
                                                     [],
                                                     message
  end

  def template_name
    if @user.partner?
      'welcome-email-partner'
    else
      'welcome-email-normal-user'
    end
  end

  def message
    {
      subject: 'Welcome to Ziltag - just one more step!',
      from_email: 'robot@ziltag.com',
      from_name: 'Ziltag',
      to: [{ email: @user.email, name: @user.username }],
      merge_vars: merge_vars
    }
  end

  def merge_vars
    [
      {
        rcpt: @user.email,
        vars: vars
      }
    ]
  end

  def vars
    ret = [
      { name: 'USERNAME', content: @user.username },
      { name: 'CONFIRM_URL', content: confirm_url }
    ]
    if @user.partner?
      ret.push name: 'DOMAIN', content: @website.url
    end
    ret
  end

  def confirm_url
    "#{host}/dashboard/verify?confirmation_token=#{encoded_token}"
  end

  def host
    "https://#{Rails.configuration.action_mailer.default_url_options[:host]}"
  end

  def encoded_token
    URI.encode_www_form_component(@user.confirmation_token)
  end
end
