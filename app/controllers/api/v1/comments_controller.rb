class Api::V1::CommentsController < ApiController
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :set_comment, only: %i[update destroy]

  def show
    @comment = Comment.find_by(id: params[:id])
  end

  def create
    @comment = current_user.comments.new comment_params
    if @comment.save
      NotifyOfComment.new(@comment).call
      render :show
    else
      render json: {errors: @comment.errors.full_messages}
    end
  end

  def update
    if @comment.update comment_params
      render :show
    else
      render json: {errors: @comment.errors.full_messages}
    end
  end

  def destroy
    @comment.destroy
    head :no_content
  end

private

  def set_comment
    @comment = Comment.find params[:id]
  end

  def comment_params
    ret = params.require(:comment).permit(:content, :ziltag_id)
    ret[:ziltag_id] = Ziltag.find_by!(slug: ret.delete(:ziltag_id)).id if ret[:ziltag_id]
    ret
  end

end
