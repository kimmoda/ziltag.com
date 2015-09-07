class AvatarUploader < CarrierWave::Uploader::Base
  include Thumbable

  def store_dir
    "uploads/#{model.class.table_name}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(model.email.downcase)}"
  end
end
