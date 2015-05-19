module FollowingHelper
  # <a class="btn btn-default btn-xs follow_user" data-follow-user data-leader-id="ID">關注用戶</a>
  # <a class="btn btn-default btn-xs follow_user cancel" data-follow-user-cancel data-leader-id="ID">取消追蹤</a>
  def following_button leader
    return unless user_signed_in?
    ret = ActiveSupport::SafeBuffer.new
    following_params = {leader_id: leader.id}

    ret << link_to('關注用戶', follow_path(following_params),
      method: :post, remote: true, class: :'btn btn-default btn-xs follow_user',
      data: {follow_user: '', leader_id: leader.id},
      style: (:'display:none' if current_user.follow? leader),
    )

    ret << link_to('取消追蹤', unfollow_path(following_params),
      method: :delete, remote: true, class: :'btn btn-default btn-xs follow_user cancel',
      data: {follow_user_cancel: '', leader_id: leader.id},
      style: (:'display:none' unless current_user.follow? leader)
    )
  end

end
