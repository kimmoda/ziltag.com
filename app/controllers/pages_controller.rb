class PagesController < ApplicationController
  def home
    @photo = Photo.new
  end

  def landing
    @subscriber = Subscriber.new
    render layout: false
  end
end
