module Thumbable
  extend ActiveSupport::Concern

  included do
    include CarrierWave::Vips
    version :thumb do
      process resize_to_fill: [50, 50]
    end
  end

  def extension_white_list
    %w[jpg jpeg gif png]
  end
end # module Thumbable