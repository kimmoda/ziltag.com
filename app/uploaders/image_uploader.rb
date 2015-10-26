# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include Thumbable

  def store_dir
    "uploads/#{model.class.table_name}/#{mounted_as}/#{model.id}"
  end

  def default_url
    model.source
  end

end
