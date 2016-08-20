# frozen_string_literal: true

class SendProductFeedbackEmail < Interactor2 #:nodoc:
  TEMPLATE_NAME = 'product-feedback'
  attr_reader :result

  def initialize(user)
    @user = user
  end

  def perform
    @result = MANDRILL_CLIENT.messages.send_template TEMPLATE_NAME,
                                                     [],
                                                     message,
                                                     nil,
                                                     nil,
                                                     2.weeks.from_now
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
        vars: [{ name: 'FNAME', content: @user.username }]
      }
    ]
  end
end
