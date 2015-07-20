class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show update destroy]

  # params[:photo_id] is required
  def index
    @comments = Comment.is_root.includes(:latest_children).where(photo_id: params.require(:photo_id)).page(params[:page]).per(10)
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    if user_signed_in?
      @comment = current_user.comments.create! comment_params
    else
      @comment = Comment.create! comment_params
    end
    render :show
  end

  def update
    @comment.update! comment_params
    render :show
  end

  def destroy
    @comment.destroy
    head :ok
  end

private

  def set_comment
    @comment = Comment.find params[:id]
  end

  def comment_params
    params.require(:comment).permit(:text, :email, :x, :y, :comment_id, :photo_id)
  end

end
