# frozen_string_literal: true

class PartnerSignUp #:nodoc:
  include Interactor

  def initialize(username, email, url)
    @username = username
    @email = email
    @url = url
    @user = ContentProvider.new username: @username, email: @email
    @box = Box.new url: url, user: @user
  end

  def call
    ActiveRecord::Base.transaction do
      if @user.save && @box.save
        context[:user] = @user
        context[:box] = @box
        SendWelcomeEmailJob.perform_later(@user)
        SubscribeNewsletterJob.perform_later(@user)
        SendNurtureEmailJob.set(wait: 1.week).perform_later(@user)
        if Rails.env.production?
          NotifyFlowdockOfSignUpJob.perform_later(@user)
        end
      else
        raise ActiveRecord::Rollback
      end
    end
    error = @user.errors.full_messages.first || @box.errors.full_messages.first
    fail! error if error
  end
end
