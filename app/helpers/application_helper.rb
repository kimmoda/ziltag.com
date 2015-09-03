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

  def link_to_with_active_class name = nil, options = nil, html_options = nil, &block
    html_options ||= {}
    html_options.merge! class: 'active' if current_page?(options)
    link_to name, options, html_options, &block
  end

end
