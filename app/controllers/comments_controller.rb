class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[update destroy]

  def create
    @comment = current_user.comments.new comment_params
    if @comment.save
      redirect_to photo_path(source: @comment.sticker.photo.source, sticker_id: @comment.sticker.id)
    else
      redirect_to request.referer
    end
  end

  def update
    if @comment.update comment_params
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
    params.require(:comment).permit(:content, :photo_id)
  end

end
