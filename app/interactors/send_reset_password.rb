# frozen_string_literal: true
class SendResetPassword < Interactor2
  TEMPLATE_NAME = 'password-reset'
  def initialize(user)
    @user = user
  end

  def perform
    @token = @user.send(:set_reset_password_token)
    MANDRILL_CLIENT.messages.send_template TEMPLATE_NAME, [], message
  rescue
    Rails.logger.error $ERROR_INFO.to_s
    Rails.logger.error $ERROR_POSITION.join
    fail! 'something went wrong'
  end

  def message
    {
      subject: 'Reset Password Instructions',
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
          { name: 'USERNAME', content: @user.username },
          { name: 'RESET_PASSWORD_URL', content: reset_password_url }
        ]
      }
    ]
  end

  def reset_password_url
    "#{host}/dashboard/password?reset_password_token=#{URI.encode_www_form_component(@token)}"
  end

  def host
    "https://#{Rails.configuration.action_mailer.default_url_options[:host]}"
  end
end
