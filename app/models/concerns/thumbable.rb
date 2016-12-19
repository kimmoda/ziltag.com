# frozen_string_literal: true
module Thumbable
  extend ActiveSupport::Concern

  included do
    include CarrierWave::MiniMagick
    version :thumb do
      process resize_to_fill_space: [100, 100]
    end
  end

  def resize_to_fill_space(width, height, gravity = 'Center')
    manipulate! do |image|
      image.combine_options do |b|
        b.thumbnail "#{width}x#{height}^"
        b.gravity gravity
        b.crop "#{width}x#{height}"
      end
      image
    end
  end
end # module Thumbable
