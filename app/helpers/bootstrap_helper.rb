module BootstrapHelper
  def alert_message message, type = :success
    content_tag :div, role: :alert, class: "alert alert-#{type} alert-dismissible fade in" do
      concat '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>'.html_safe
      concat message
    end    
  end

  def icon_tag name
    content_tag :span, nil, class: "glyphicon glyphicon-#{name}"
  end

  def link_li name, path
    active = request.path.start_with?(path) ? :active : nil
    link = link_to name, path
    content_tag :li, link, class: active
  end
end
