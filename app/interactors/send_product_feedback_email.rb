# frozen_string_literal: true

class SendProductFeedbackEmail #:nodoc:
  include Interactor
  TEMPLATE_NAME = 'product-feedback'

  def initialize(user)
    @user = user
  end

  def call
    context[:result] = MANDRILL_CLIENT.messages.send_template TEMPLATE_NAME,
                                                              [],
                                                              message,
                                                              nil,
                                                              nil,
                                                              2.weeks.from_now
  rescue
    fail! $ERROR_INFO
  end

  def message
    {
      subject: "Hi #{@user.username}! What can we do better for you?",
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
