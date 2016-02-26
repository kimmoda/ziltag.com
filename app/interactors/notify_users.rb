class NotifyUsers
  def initialize comment
    @comment = comment
  end

  def call
    return unless @comment.user.confirmed?
    users = @comment.sibling_commenters.to_a
    ziltag_author = @comment.ziltag.user
    users << ziltag_author unless users.include?(ziltag_author)
    users.each do |user|
      NotificationMailer.new_comment_notification(user, @comment).deliver_later
    end
  end
end