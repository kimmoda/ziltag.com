module AdminHelper
  def admin_flash_messages
    ret = ActiveSupport::SafeBuffer.new
    ret << alert_message(notice, :success) if notice
    ret << alert_message(alert, :danger) if alert
    ret
  end

  def link_li_for model
    link_li model.model_name.human, polymorphic_path(model)
  end
end
