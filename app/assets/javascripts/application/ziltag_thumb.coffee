define_component 'ziltag_thumb', (thumb) ->
  wrapper = thumb.getElementsByClassName('ziltag_wrapper')[0]
  img = wrapper.getElementsByTagName('img')[0]
  tag = wrapper.getElementsByTagName('a')[0]

  handler = () ->
    ratio_x = img.clientWidth / img.naturalWidth
    ratio_y = img.clientHeight / img.naturalHeight

    right = tag.dataset.x * ratio_x - 150
    right = img.clientWidth - 300 if right > img.clientWidth - 300
    right = 0 if right < 0
    wrapper.style.right = right + 'px'

    bottom = tag.dataset.y * ratio_y - 150
    bottom = img.clientHeight - 300 if bottom > img.clientHeight - 300
    bottom = 0 if bottom < 0
    wrapper.style.bottom = bottom + 'px'

  if img.complete then handler()
  else img.addEventListener 'load', handler