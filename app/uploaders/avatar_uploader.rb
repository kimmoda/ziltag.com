class AvatarUploader < CarrierWave::Uploader::Base
  include Thumbable

  def store_dir
    "uploads/#{model.class.table_name}/#{mounted_as}/#{model.id}"
  end

  def default_url
    if Rails.env.production?
      fallback = URI.encode ActionController::Base.helpers.image_path('fallback/' + [version_name, 'guest.png'].compact.join('_'))
      "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(model.email.downcase)}?d=#{URI.encode fallback}"
    else
      ActionController::Base.helpers.image_path('fallback/' + [version_name, 'guest.png'].compact.join('_'))
    end
  end

  version :default do
    process resize_to_fill: [180, 180]
  end
end
