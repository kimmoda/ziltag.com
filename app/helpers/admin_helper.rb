module AdminHelper
  def flash_messages
    ret = ActiveSupport::SafeBuffer.new
    ret << alert_message(notice, :success) if notice
    ret << alert_message(alert, :danger) if alert
    ret
  end
end
