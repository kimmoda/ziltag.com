class SubscribtionController < ApplicationController
  def unsubscribe
    user_id, ziltag_id = Unsubscribe.verify params[:token]
    user = User.find(user_id)
    ziltag = Ziltag.find(ziltag_id)
    Unsubscribe.new(user, ziltag).call
  rescue ActiveSupport::MessageVerifier::InvalidSignature, ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
