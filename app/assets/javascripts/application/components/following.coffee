get_block_elements_by_leader = (leader_id) ->
  document.querySelectorAll("[data-leader-id=\"#{leader_id}\"]")

request_options = (leader_id, action) ->
  method: if action == 'follow' then 'post' else 'delete'
  body: JSON.stringify leader_id: leader_id
  credentials: 'same-origin'
  headers: 'Content-Type': 'application/json'

define_component 'following-button', (block) ->
  follow_btn = block.getElementsByClassName('following-button__follow')[0]
  unfollow_btn = block.getElementsByClassName('following-button__unfollow')[0]

  follow_btn.addEventListener 'click', ->
    fetch '/api/v1/following', request_options(block.dataset.leaderId, 'follow')
    .then (response) ->
      for element in get_block_elements_by_leader(block.dataset.leaderId)
        element.getElementsByClassName('following-button__follow')[0].style.display = 'none'
        element.getElementsByClassName('following-button__unfollow')[0].style.display = ''

  unfollow_btn.addEventListener 'click', ->
    fetch '/api/v1/following', request_options(block.dataset.leaderId, 'unfollow')
    .then (response) ->
      for element in get_block_elements_by_leader(block.dataset.leaderId)
        element.getElementsByClassName('following-button__follow')[0].style.display = ''
        element.getElementsByClassName('following-button__unfollow')[0].style.display = 'none'