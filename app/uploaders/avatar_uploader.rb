class AvatarUploader < CarrierWave::Uploader::Base
  include Thumbable

  def store_dir
    "uploads/#{model.class.table_name}/#{mounted_as}/#{model.id}"
  end

  def default_url
    '/images/fallback/' << [version_name, 'guest.png'].compact.join('_')
  end
end
