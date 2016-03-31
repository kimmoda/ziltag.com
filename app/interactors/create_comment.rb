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
        NotifyOfComment.call(@comment)
        results[:comment] = @comment
      else
        errors[:comment_errors] = @comment.errors.full_messages
      end
      raise ActiveRecord::Rollback unless success?
    end
  end

end