# frozen_string_literal: true

# upgrade nromal user to partner
class UpgradeUser
  include Interactor

  def initialize(user, url)
    @user = user
    @url = url
  end

  def call
    box = Box.new user: @user, url: @url
    @user.update_column :type, 'Partner'
    if box.save
      context[:user] = @user
      ChangeMailchimpRoleJob.perform_later(user, 'partner')
      SendNurtureEmailJob.set(wait: 1.week).perform_later(@user)
    else
      fail! box.errors.full_messages.first
    end
  end
end
