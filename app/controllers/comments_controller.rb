class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[update destroy]

  def create
    @comment = current_user.comments.new comment_params
    if @comment.save
      redirect_to photo_path(src: @comment.ziltag.photo.source, ziltag_id: @comment.ziltag.id)
    else
      redirect_to request.referer
    end
  end

  def update
    if @comment.update comment_params
      redirect_to photo_path(src: @comment.ziltag.photo.source, ziltag_id: @comment.ziltag.id)
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
