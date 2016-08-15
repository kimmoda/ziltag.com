# frozen_string_literal: true
class SubscribtionController < ApplicationController
  def unsubscribe
    user_id, ziltag_id = Unsubscribe.verify params[:token]
    user = User.find(user_id)
    ziltag = Ziltag.find(ziltag_id)
    Unsubscribe.new(user, ziltag).call
    redirect_to "/dashboard/unsubscribe?token=#{params[:token]}"
  rescue
    redirect_to root_path
  end
end
