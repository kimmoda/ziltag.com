class CoverUploader < CarrierWave::Uploader::Base
  include Thumbable

  version :default do
    process resize_to_fill_space: [1000, 500]
  end

  def store_dir
    "uploads/#{model.class.table_name}/#{mounted_as}/#{model.id}"
  end

  def default_url
    '/images/fallback/' << [version_name, "cover_#{model.email[0].ord % 4 + 1}.jpg"].compact.join('_')
  end
end
