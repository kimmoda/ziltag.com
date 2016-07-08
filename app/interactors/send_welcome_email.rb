# frozen_string_literal: true

class SendWelcomeEmail #:nodoc:
  include Interactor

  def initialize(user)
    @user = user
    @box = user.box
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
        vars: vars
      }
    ]
  end

  def vars
    ret = [
      { name: 'USERNAME', content: @user.username },
      { name: 'CONFIRM_URL', content: confirm_url }
    ]
    if @user.content_provider?
      ret.push(
        { name: 'DOMAIN', content: @box.url },
        { name: 'SCRIPT', content: escaped_script_html }
      )
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

  def escaped_script_html
    CGI.escapeHTML(
      %(<script src="#{host}/plugin.js" data-ziltag="#{@box.token}"></script>)
    )
  end
end
