# 此檔案定義了 data-follow-user 與 data-follow-user-cancel，需要兩兩成對使用，例：
# <a class="btn btn-default btn-xs follow_user" data-follow-user>關注用戶</a>
# <a class="btn btn-default btn-xs follow_user cancel" data-follow-user-cancel>取消追蹤</a>
toggle = (leader_id, action) ->
  data_leader_id = "[data-leader-id=\"#{leader_id}\"]"
  data_follow_user = "#{data_leader_id}[data-follow-user]"
  data_follow_user_cancle = "#{data_leader_id}[data-follow-user-cancel]"
  switch action
    when 'follow'
      $(data_follow_user).hide()
      $(data_follow_user_cancle).show()
    when 'unfollow'
      $(data_follow_user_cancle).hide()
      $(data_follow_user).show()

$(document).on 'ready page:load', () ->
  $('body').on 'ajax:success', '[data-follow-user]', () ->
    toggle(this.dataset.leaderId, 'follow')
  $('body').on 'ajax:success', '[data-follow-user-cancel]', () ->
    toggle(this.dataset.leaderId, 'unfollow')