module FontAwesomeHelper
  # <i class="fa fa-picture-o"></i> 以圖找貼
  def fa name, text = nil
    ret = content_tag(:i, nil, class: "fa fa-#{name}")
    ret << ' ' << text if text
    ret
  end
end
