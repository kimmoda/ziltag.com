MAX_WIDTH = MAX_HEIGHT = 300

define_component 'ziltag_thumb', (thumb) ->
  wrapper = thumb.getElementsByClassName('ziltag_wrapper')[0]
  img = wrapper.getElementsByTagName('img')[0]
  tag = wrapper.getElementsByTagName('a')[0]

  handler = () ->
    ratio_x = img.clientWidth / img.naturalWidth
    ratio_y = img.clientHeight / img.naturalHeight

    right = tag.dataset.x * ratio_x - MAX_WIDTH/2
    right = img.clientWidth - MAX_WIDTH if right > img.clientWidth - MAX_WIDTH
    right = 0 if right < 0
    wrapper.style.right = right + 'px'

    bottom = tag.dataset.y * ratio_y - MAX_HEIGHT/2
    bottom = img.clientHeight - MAX_HEIGHT if bottom > img.clientHeight - MAX_HEIGHT
    bottom = 0 if bottom < 0
    wrapper.style.bottom = bottom + 'px'

  if img.complete then handler()
  else img.addEventListener 'load', handler