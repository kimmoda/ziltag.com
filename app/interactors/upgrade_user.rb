# frozen_string_literal: true

# upgrade nromal user to partner
class UpgradeUser < Interactor2
  attr_reader :user
  def initialize(user, url)
    @user = user
    @url = url
  end

  def perform
    website = Website.new user: @user, url: @url
    @user.update_column :type, 'Partner'
    if website.save
      ChangeMailchimpRoleJob.perform_later(user, 'partner')
      SendNurtureEmailJob.set(wait: 1.week).perform_later(@user)
    else
      fail! website.errors.full_messages.first
    end
  end
end
