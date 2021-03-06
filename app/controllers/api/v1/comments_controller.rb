# frozen_string_literal: true
class Api::V1::CommentsController < ApiController
  before_action :set_comment, only: %i(update destroy)

  def show
    @comment = Comment.find_by(id: params[:id])
  end

  def create
    user = if Rails.env.production? && Settings.host == 'ziltag.com' &&
              demo_token == Ziltag.find_by(id: comment_params[:ziltag_id])&.photo&.website&.token
      demo_user
    else
      authenticate_user!
      current_user
    end
    create_comment = CreateComment.perform(user, comment_params)
    if create_comment.success?
      @comment = create_comment.comment
      render :show
    else
      render json: { error: create_comment.error }
    end
  end

  def update
    if @comment.update comment_params
      NotifySSE.perform(:update, @comment)
      render :show
    else
      render json: { errors: @comment.errors.full_messages }
    end
  end

  def destroy
    @comment.destroy
    NotifySSE.perform(:delete, @comment)
    head :no_content
  end

  private

  def set_comment
    @comment = Comment.find params[:id]
  end

  def comment_params
    ret = params.require(:comment).permit(:content, :ziltag_id)
    ret[:ziltag_id] = Ziltag.find_by!(natural_id: ret.delete(:ziltag_id)).id if ret[:ziltag_id]
    ret
  end
end
