module CollectingHelper
  def collecting_button record
    return unless user_signed_in?
    ret = ActiveSupport::SafeBuffer.new
    ret << link_to(fa(:star), collect_path(id: record.id, type: record.class.name),
      data: {class: dom_id(record)}, class: "collect #{dom_id(record)}",
      method: :post, remote: true,
      style: (:'display:none' if current_user.collect? record)
    )
    ret << link_to(fa(:star), uncollect_path(id: record.id, type: record.class.name),
      data: {class: dom_id(record)}, class: "uncollect #{dom_id(record)}",
      method: :delete, remote: true,
      style: (:'display:none' unless current_user.collect? record)
    )
  end

end
