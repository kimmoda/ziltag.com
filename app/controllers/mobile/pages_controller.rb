require 'service_url_converter'

class Mobile::PagesController < MobileController
  def home
  end

  def register
    if params[:platform] == 'general' || params[:blog_id].present?
      url = ServiceURLConverter.convert(params)
      guest = Guest.new(username: params[:username], email: params[:email], url: url)
      error = if !guest.valid_username? then guest.user.errors[:username].first
      elsif !guest.valid_email? then guest.user.errors[:email].first
      elsif !guest.valid_url? then guest.box.errors[:url].first
      end
    else
      error = 'Blog ID can not be blank'
    end

    if error
      render json: {error: error}
    else
      guest.create_user!
      render json: {}
    end
  end
end
