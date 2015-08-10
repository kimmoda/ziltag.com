get_block_elements_by_leader = (leader_id) ->
  document.querySelectorAll("[data-leader-id=\"#{leader_id}\"]")

request_options = (leader_id, type) ->
  method: if type == 'follow' then 'post' else 'delete'
  body: JSON.stringify leader_id: leader_id
  credentials: 'same-origin'
  headers: 'Content-Type': 'application/json'

define_component 'following-block', (block) ->
  follow_btn = block.getElementsByClassName('following-block__follow')[0]
  unfollow_btn = block.getElementsByClassName('following-block__unfollow')[0]
  body = JSON.stringify leader_id: block.dataset.leaderId
  credentials = 'same-origin'
  headers = 'Content-Type': 'application/json'

  follow_btn.addEventListener 'click', ->
    fetch '/api/v1/following', request_options(block.dataset.leaderId, 'follow')
    .then (response) ->
      for element in get_block_elements_by_leader(block.dataset.leaderId)
        element.getElementsByClassName('following-block__follow')[0].style.display = 'none'
        element.getElementsByClassName('following-block__unfollow')[0].style.display = ''

  unfollow_btn.addEventListener 'click', ->
    fetch '/api/v1/following', request_options(block.dataset.leaderId, 'unfollow')
    .then (response) ->
      for element in get_block_elements_by_leader(block.dataset.leaderId)
        element.getElementsByClassName('following-block__follow')[0].style.display = ''
        element.getElementsByClassName('following-block__unfollow')[0].style.display = 'none'