class ShareImageUploader < CarrierWave::Uploader::Base
  include Thumbable
  CROP_WIDTH, CROP_HEIGHT = 600, 315

  process :tag

  def tag
    manipulate! do |image|
      if image.width/image.height > CROP_WIDTH/CROP_HEIGHT
        resized_height = CROP_HEIGHT
        resized_width = image.width * (resized_height.to_f/image.height)
      else
        resized_width = CROP_WIDTH
        resized_height = image.height * (resized_width.to_f/image.width)
      end

      ziltag_x = resized_width * model.x
      ziltag_y = resized_height * model.y

      crop_x = ziltag_x - CROP_WIDTH/2

      if crop_x < 0
        crop_x = 0
      elsif crop_x > resized_width - CROP_WIDTH
        crop_x = resized_width - CROP_WIDTH
      end

      crop_y = ziltag_y - CROP_HEIGHT/2

      if crop_y < 0
        crop_y = 0
      elsif crop_y > resized_height - CROP_HEIGHT
        crop_y = resized_height - CROP_HEIGHT
      end

      image.combine_options do |b|
        b.quality 100
        b.geometry "#{CROP_WIDTH}x#{CROP_HEIGHT}^"
        b.stroke 'red'
        b.strokewidth 2
        b.fill 'rgba(255,255,255,30)'
        b.draw "circle #{ziltag_x},#{ziltag_y} #{ziltag_x},#{ziltag_y+10}"
        b.crop "#{CROP_WIDTH}x#{CROP_HEIGHT}#{'%+d' % crop_x}#{'%+d' % crop_y}"
      end
      image.format 'jpg'
      image
    end
  end

  def filename
    'share.jpg'
  end

  def store_dir
    "uploads/#{model.class.table_name}/#{mounted_as}/#{model.id}"
  end

  def default_url
    model.photo.image_url
  end

end
