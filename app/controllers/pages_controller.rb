class PagesController < ApplicationController
  def home
    @photo = Photo.new
  end

  def landing
    @subscriber = Subscriber.new
    render layout: false
  end

  def term_of_service
  end

  def privacy_policy
  end
end
