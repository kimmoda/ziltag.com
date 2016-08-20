# frozen_string_literal: true
class CreateComment < Interactor2 #:nodoc:
  attr_reader :comment

  def initialize(user, comment_params)
    @user = user
    @comment = Comment.new comment_params.merge(user: user)
  end

  def perform
    ActiveRecord::Base.transaction do
      if @comment.save
        NotifySSE.perform(:create, @comment)
        Subscribe.perform(@user, @comment.ziltag)
        if @comment.user.confirmed?
          SendCommentNotificationJob.perform_later(@comment)
        end
      else
        raise ActiveRecord::Rollback
      end
    end
    fail! @comment.errors.full_messages.first unless @comment.valid?
  end
end
