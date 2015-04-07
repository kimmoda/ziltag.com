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
end
