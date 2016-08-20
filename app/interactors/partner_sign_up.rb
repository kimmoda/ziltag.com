# frozen_string_literal: true

class PartnerSignUp #:nodoc:
  include Interactor

  def initialize(username, email, url)
    @username = username
    @email = email
    @url = url
    @user = Partner.new username: @username, email: @email
    @website = Website.new url: url, user: @user
  end

  def call
    ActiveRecord::Base.transaction do
      if @user.save && @website.save
        context[:user] = @user
        context[:website] = @website
        SendWelcomeEmailJob.perform_later(@user)
        SubscribeNewsletterJob.perform_later(@user)
        SendNurtureEmailJob.set(wait: 1.week).perform_later(@user)
        NotifyFlowdockOfSignUpJob.perform_later(@user) if Rails.env.production?
      else
        raise ActiveRecord::Rollback
      end
    end
    error = @user.errors.full_messages.first || @website.errors.full_messages.first
    fail! error if error
  end
end
