module FollowingHelper
  # 產生成對的追蹤按鈕
  # <a class="follow" data-leader-id="ID">關注用戶</a>
  # <a class="unfollow" data-leader-id="ID">取消追蹤</a>
  def following_button leader
    return unless user_signed_in?
    return if current_user == leader
    ret = ActiveSupport::SafeBuffer.new
    following_params = {leader_id: leader.id}

    ret << link_to('關注用戶', follow_path(following_params),
      method: :post, remote: true, class: :follow,
      data: {leader_id: leader.id},
      style: (:'display:none' if current_user.follow? leader),
    )

    ret << link_to('取消追蹤', unfollow_path(following_params),
      method: :delete, remote: true, class: :unfollow,
      data: {leader_id: leader.id},
      style: (:'display:none' unless current_user.follow? leader)
    )
  end

end
