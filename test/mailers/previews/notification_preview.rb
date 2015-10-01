class NotificationPreview < ActionMailer::Preview
  def new_comment_notification
    NotificationMailer.new_comment_notification(User.first, Comment.first)
  end
end