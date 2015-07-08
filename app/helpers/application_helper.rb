module ApplicationHelper
  def flash_messages
    ret = ActiveSupport::SafeBuffer.new
    ret << alert_message(notice, :info) if notice
    ret << alert_message(alert, :danger) if alert
    ret
  end

  def time_info date_or_time, opts = {}
    time_tag date_or_time, {class: :datetime}.merge!(opts) do
      '發表於 ' << l(date_or_time, format: :long)
    end
  end

  def feature_ziltag
    if photo = Photo.find_by(id: Settings[:feature_photo_id])
      ziltag_wrapper photo, photo.ziltaggings
    end
  end

end
