module ZiltagHelper
  def ziltag_thumb ziltagging
    content_tag :div, class: :ziltag_thumb do
      ziltag_wrapper ziltagging.photo, ziltagging, active: ziltagging
    end
  end

  def ziltag_wrapper photo, ziltaggings, active: nil, interact: :modal, comments: false
    case interact
    when :modal
      data_ziltag = {ziltag_modal: ''}
    when :replace
      data_ziltag = {ziltag_replace: ''}
    else raise "Unknown interact type: #{interact}"
    end

    data_comments = comments ? {comments: ''} : {}

    content_tag :div, class: :ziltag_wrapper, data: data_comments do
      concat image_tag photo.image_url, data: {photo_id: photo.id}
      Array(ziltaggings).each do |ziltagging|
        link_options = {
          class: (:active if Array(active).include? ziltagging),
          remote: true,
          data: {x: ziltagging.x, y: ziltagging.y}.merge!(data_ziltag)
        }
        concat link_to '', ziltagging_path(ziltagging, format: :json), link_options
      end
    end
  end

end
