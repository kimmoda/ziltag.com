class NotificationPreview < ActionMailer::Preview
  def new_comment_notification
    NotificationMailer.new_comment_notification(User.first, Comment.first)
  end

  def new_ziltag_notification
    NotificationMailer.new_ziltag_notification(User.first, Ziltag.first)
  end
end