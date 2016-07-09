class CreateComment
  include Interactor

  def initialize user, comment_params
    @user = user
    @comment = Comment.new comment_params.merge(user: user)
  end

  def call
    ActiveRecord::Base.transaction do
      if @comment.save
        Subscribe.call(@user, @comment.ziltag)
        if @comment.user.confirmed?
          SendCommentNotificationJob.perform_later(@comment)
        end
        context[:comment] = @comment
      else
        raise ActiveRecord::Rollback
      end
    end
    fail! @comment.errors.full_messages.first unless @comment.valid?
  end

end
