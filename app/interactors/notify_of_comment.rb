class NotifyOfComment
  include Interactor

  def initialize comment
    @comment = comment
    @comment_author = comment.user
    @sibling_commenters = @comment.sibling_commenters.to_a
    @ziltag_author = @comment.ziltag.user
    @unsubscriber_ids = @comment.ziltag.unsubscribers
  end

  def call
    return unless @comment_author.confirmed?
    users = @sibling_commenters.dup
    users << @ziltag_author unless @sibling_commenters.include?(@ziltag_author)
    users.each do |user|
      unless @unsubscriber_ids.include?(user.id)
        NotificationMailer.new_comment_notification(user, @comment).deliver_later
      end
    end
  end
end