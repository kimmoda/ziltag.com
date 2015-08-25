class SubscribersController < ApplicationController
  def create
    Subscriber.create email: params[:subscriber][:email]
  rescue
  ensure
    redirect_to root_path, notice: 'Thanks for your subscription!'
  end
end
