get_block_elements_by_id_and_type = (id, type) ->
  document.querySelectorAll("[data-id=\"#{id}\"][data-type=\"#{type}\"]")

request_options = (id, type, action) ->
  method: if action == 'collect' then 'post' else 'delete'
  body: JSON.stringify
    id: id
    type: type
  credentials: 'same-origin'
  headers: 'Content-Type': 'application/json'

define_component 'collecting-button', (block) ->
  collect_btn = block.getElementsByClassName('collecting-button__collect')[0]
  uncollect_btn = block.getElementsByClassName('collecting-button__uncollect')[0]

  collect_btn.addEventListener 'click', ->
    fetch '/api/v1/collecting', request_options(block.dataset.id, block.dataset.type, 'collect')
    .then (response) ->
      for element in get_block_elements_by_id_and_type(block.dataset.id, block.dataset.type)
        element.getElementsByClassName('collecting-button__collect')[0].style.display = 'none'
        element.getElementsByClassName('collecting-button__uncollect')[0].style.display = ''

  uncollect_btn.addEventListener 'click', ->
    fetch '/api/v1/collecting', request_options(block.dataset.id, block.dataset.type, 'uncollect')
    .then (response) ->
      for element in get_block_elements_by_id_and_type(block.dataset.id, block.dataset.type)
        element.getElementsByClassName('collecting-button__collect')[0].style.display = ''
        element.getElementsByClassName('collecting-button__uncollect')[0].style.display = 'none'