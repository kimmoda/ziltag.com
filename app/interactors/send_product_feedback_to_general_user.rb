# frozen_string_literal: true
class SendProductFeedbackToGeneralUser < Interactor2 #:nodoc:
  attr_reader :result
  TEMPLATE_NAME = 'product-feedback-normal-user'

  def initialize(user)
    @user = user
  end

  def perform
    @result = MANDRILL_CLIENT.messages.send_template TEMPLATE_NAME,
                                                     [],
                                                     message,
                                                     nil,
                                                     nil,
                                                     1.week.from_now
  end

  def message
    {
      subject: "Hi #{@user.username}! Help us to make Ziltag better.",
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
        vars: [{ name: 'USERNAME', content: @user.username }]
      }
    ]
  end
end
