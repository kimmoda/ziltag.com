# 追蹤按鈕
# <a class="follow" data-leader-id="ID">關注用戶</a>
# <a class="unfollow" data-leader-id="ID">取消追蹤</a>

toggle = (leader_id, action) ->
  data_leader_id = "[data-leader-id=\"#{leader_id}\"]"
  follows = document.querySelectorAll "a.follow#{data_leader_id}"
  unfollows = document.querySelectorAll "a.unfollow#{data_leader_id}"
  switch action
    when 'follow'
      follow.style.display = 'none' for follow in follows
      unfollow.style.display = '' for unfollow in unfollows
    when 'unfollow'
      unfollow.style.display = 'none' for unfollow in unfollows
      follow.style.display = '' for follow in follows

main () ->
  $(document.body).on 'ajax:success', 'a.follow', () ->
    toggle(this.dataset.leaderId, 'follow')
  $(document.body).on 'ajax:success', 'a.unfollow', () ->
    toggle(this.dataset.leaderId, 'unfollow')