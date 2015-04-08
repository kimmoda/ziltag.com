class <%= class_name %>Uploader < CarrierWave::Uploader::Base
  include Thumbable

  def store_dir
    "uploads/#{model.class.table_name}/#{mounted_as}/#{model.id}"
  end
end
