module Thumbable
  extend ActiveSupport::Concern

  included do
    include CarrierWave::MiniMagick
    version :thumb do
      process resize_to_fill_space: [50, 50]
    end
  end

  # TODO: resize_to_fill 在 graphicsmagick 上會有問題
  # https://github.com/carrierwaveuploader/carrierwave/issues/1520
  def resize_to_fill_space(width, height, gravity = 'Center')
    manipulate! do |image|
      MiniMagick::Tool::Convert.new do |convert|
        convert << image.path # input
        convert.thumbnail "#{width}x#{height}^"
        convert.gravity gravity
        convert.extent "#{width}x#{height}"
        convert << image.path # output
      end
      image
    end
  end

  def extension_white_list
    %w[jpg jpeg gif png]
  end
end # module Thumbable