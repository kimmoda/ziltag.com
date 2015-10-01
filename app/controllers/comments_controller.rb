class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[update destroy]

  def create
    @comment = current_user.comments.new comment_params
    if @comment.save
      if current_user.confirmed?
        @comment.notify_users
      else
        flash.notice = 'Your comment will be pending until you finish account confirmation.'
      end
      redirect_to photo_path(@comment.ziltag.photo, @comment.ziltag)
    else
      redirect_to request.referer
    end
  end

  def update
    if @comment.update comment_params
      redirect_to photo_path(@comment.ziltag.photo, @comment.ziltag)
    else
      redirect_to request.referer
    end
  end

  def destroy
    @comment.destroy
    redirect_to request.referer
  end

private

  def set_comment
    @comment = Comment.find params[:id]
  end

  def comment_params
    params.require(:comment).permit(:content, :ziltag_id)
  end

end
