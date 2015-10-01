class NotificationMailer < ApplicationMailer
  def new_comment_notification(user, comment)
    @user = user
    @comment = comment
    mail to: @user.email
  end

end
