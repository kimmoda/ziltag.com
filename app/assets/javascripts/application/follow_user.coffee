# 此檔案定義了 data-follow-user 與 data-follow-user-cancel，需要兩兩成對使用，例：
# <a class="btn btn-default btn-xs follow_user" data-follow-user data-leader-id="ID">關注用戶</a>
# <a class="btn btn-default btn-xs follow_user cancel" data-follow-user-cancel data-leader-id="ID">取消追蹤</a>
toggle = (leader_id, action) ->
  data_leader_id = "[data-leader-id=\"#{leader_id}\"]"
  follow_users = document.querySelectorAll "#{data_leader_id}[data-follow-user]"
  follow_users_cancle = document.querySelectorAll "#{data_leader_id}[data-follow-user-cancel]"
  switch action
    when 'follow'
      follow_user.style.display = 'none' for follow_user in follow_users
      follow_user_cancle.style.display = '' for follow_user_cancle in follow_users_cancle
    when 'unfollow'
      follow_user_cancle.style.display = 'none' for follow_user_cancle in follow_users_cancle
      follow_user.style.display = '' for follow_user in follow_users

main () ->
  $(document.body).on 'ajax:success', '[data-follow-user]', () ->
    toggle(this.dataset.leaderId, 'follow')
  $(document.body).on 'ajax:success', '[data-follow-user-cancel]', () ->
    toggle(this.dataset.leaderId, 'unfollow')