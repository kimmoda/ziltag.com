# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include Thumbable

  def store_dir
    "uploads/#{model.class.table_name}/#{mounted_as}/#{model.id}"
  end

  def default_url
    model.source
  end

  version :default do
    process resize_to_fit: [510, 340]
    process :store_dimensions
  end

  private

  def store_dimensions
    if file && model
      model.width, model.height = ::MiniMagick::Image.open(file.file)[:dimensions]
    end
  end
end
