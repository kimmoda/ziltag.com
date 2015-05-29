module ZiltagHelper
  def ziltag_thumb ziltagging
    content_tag :div, class: :ziltag_thumb do
      ziltag_wrapper ziltagging.photo, ziltagging, active: ziltagging
    end
  end

  def ziltag_wrapper photo, ziltaggings, active: nil
    content_tag :div, class: :ziltag_wrapper do
      concat image_tag photo.image_url
      Array(ziltaggings).each do |ziltagging|
        link_options = {
          class: (:active if Array(active).include? ziltagging),
          remote: true,
          data: {ziltag_modal: true, x: ziltagging.x, y: ziltagging.y}
        }
        concat link_to '', ziltagging_path(ziltagging, format: :json), link_options
      end
    end
  end

end
