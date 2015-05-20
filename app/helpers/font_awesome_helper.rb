module FontAwesomeHelper
  # <i class="fa fa-picture-o"></i> 以圖找貼
  def fa name, text
    content_tag(:i, nil, class: "fa fa-#{name}") << ' ' << text
  end
end
