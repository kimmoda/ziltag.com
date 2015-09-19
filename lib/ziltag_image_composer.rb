require 'mini_magick'

class ZiltagImageComposer
  CROP_WIDTH, CROP_HEIGHT = 600, 315

  def initialize crop_width=CROP_WIDTH, crop_height=CROP_HEIGHT
    @crop_width, @crop_height = crop_width, crop_height
  end

  def convert input, x, y
    image = MiniMagick::Image.open input

    if image.width/image.height > @crop_width/@crop_height
      resized_height = @crop_height
      resized_width = image.width * (resized_height.to_f/image.height)
    else
      resized_width = @crop_width
      resized_height = image.height * (resized_width.to_f/image.width)
    end

    ziltag_x = resized_width * x
    ziltag_y = resized_height * y

    crop_x = ziltag_x - @crop_width/2

    if crop_x < 0
      crop_x = 0
    elsif crop_x > resized_width - @crop_width
      crop_x = resized_width - @crop_width
    end

    crop_y = ziltag_y - @crop_height/2

    if crop_y < 0
      crop_y = 0
    elsif crop_y > resized_height - @crop_height
      crop_y = resized_height - @crop_height
    end

    image.combine_options do |b|
      b.geometry "#{@crop_width}x#{@crop_height}^"
      b.stroke 'red'
      b.strokewidth 2
      b.fill 'rgba(255,255,255,30)'
      b.draw "circle #{ziltag_x},#{ziltag_y} #{ziltag_x},#{ziltag_y+10}"
      b.crop "#{@crop_width}x#{@crop_height}#{'%+d' % crop_x}#{'%+d' % crop_y}"
    end
    image
  end
end