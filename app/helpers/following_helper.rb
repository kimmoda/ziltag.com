=begin
<div class="following-button" data-leader-id="ID">
  <button class="following-button__follow">關注用戶</button>
  <button class="following-button__unfollow">取消追蹤</button>
</div>
=end

module FollowingHelper
  def following_button leader
    return unless user_signed_in?
    return if current_user == leader
    ret = ActiveSupport::SafeBuffer.new
    following_params = {leader_id: leader.id}

    content_tag :div, class: 'following-button', data: {leader_id: leader.id} do
      concat content_tag :button, t('關注用戶'), class: 'following-button__follow', style: (:'display:none' if current_user.follow? leader)
      concat content_tag :button, t('取消追蹤'), class: 'following-button__unfollow', style: (:'display:none' unless current_user.follow? leader)
    end
  end

end
