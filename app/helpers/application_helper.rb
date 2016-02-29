module ApplicationHelper
  def copy_script_tag token
    %Q{<script src="#{Rails.configuration.action_controller.asset_host}/plugin.js" data-ziltag="#{token}"></script>}
  end
end
