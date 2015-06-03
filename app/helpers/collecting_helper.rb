module CollectingHelper
  def collecting_link record, dom_class
    case dom_class
    when :collect
      link_method = :post
      link_style = current_user.collect?(record) ? :'display:none' : nil
    when :uncollect then :delete
      link_method = :delete
      link_style = current_user.collect?(record) ? nil : :'display:none'
    else raise "Unknown dom_class: #{dom_class}"
    end

    link_options = {id: record.id, type: record.class.name}
    link_path = dom_class == :collect ? collect_path(link_options) : uncollect_path(link_options)
    link_to(fa(:star), link_path,
      data: {class: dom_id(record)},
      class: "#{dom_class} #{dom_id(record)}",
      method: link_method,
      remote: true,
      style: link_style
    )
  end

  def collecting_button record
    return unless user_signed_in?
    ret = ActiveSupport::SafeBuffer.new
    ret << collecting_link(record, :collect)
    ret << collecting_link(record, :uncollect)
  end

end
