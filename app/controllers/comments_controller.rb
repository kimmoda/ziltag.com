class CommentsController < ApplicationController
  # params[:photo_id] is required
  def index
    @comments = Comment.is_root.includes(:latest_children).where(photo_id: params.require(:photo_id)).page(params[:page]).per(10)
  end

  def show
    @comment = Comment.find(params[:id])
  end
end
