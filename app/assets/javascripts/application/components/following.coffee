get_block_elements_by_leader = (leader_id) ->
  document.querySelectorAll("[data-leader-id=\"#{leader_id}\"]")

define_component 'following-block', (block) ->
  follow_btn = block.getElementsByClassName('following-block__follow')[0]
  unfollow_btn = block.getElementsByClassName('following-block__unfollow')[0]
  body = JSON.stringify leader_id: block.dataset.leaderId
  headers = 'Content-Type': 'application/json'

  follow_btn.addEventListener 'click', ->
    fetch '/api/v1/following',
      method: 'post'
      credentials: 'same-origin'
      headers: headers
      body: body
    .then (response) ->
      for element in get_block_elements_by_leader(block.dataset.leaderId)
        element.getElementsByClassName('following-block__follow')[0].style.display = 'none'
        element.getElementsByClassName('following-block__unfollow')[0].style.display = ''

  unfollow_btn.addEventListener 'click', ->
    fetch '/api/v1/following',
      method: 'delete'
      credentials: 'same-origin'
      headers: headers
      body: body
    .then (response) ->
      for element in get_block_elements_by_leader(block.dataset.leaderId)
        element.getElementsByClassName('following-block__follow')[0].style.display = ''
        element.getElementsByClassName('following-block__unfollow')[0].style.display = 'none'