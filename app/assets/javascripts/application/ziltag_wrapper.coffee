ziltag_wrapper = () ->
  for wrapper in document.getElementsByClassName('ziltag_wrapper')
    do (wrapper) ->
      img = wrapper.getElementsByTagName('img')[0]
      tags = wrapper.getElementsByTagName('a')

      handler = () ->
        ratio_x = img.clientWidth / img.naturalWidth
        ratio_y = img.clientHeight / img.naturalHeight

        for tag in tags
          tag.style.left = tag.dataset.x * ratio_x + 'px'
          tag.style.top = tag.dataset.y * ratio_y + 'px'

      if img.complete then handler()
      else img.addEventListener 'load', handler

document.addEventListener event, ziltag_wrapper for event in ['DOMContentLoaded', 'page:load']