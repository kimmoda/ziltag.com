module Thumbable
  extend ActiveSupport::Concern

  included do
    include CarrierWave::MiniMagick
    version :thumb do
      process resize_to_fill: [100, 100]
    end
  end

  def extension_white_list
    %w[jpg jpeg gif png]
  end
end # module Thumbable