ziltag_sticker = () ->
  for wrapper in document.getElementsByClassName('ziltag_wrapper')
    img = wrapper.getElementsByTagName('img')[0]
    tags = wrapper.getElementsByClassName('ziltag_sticker')
    do (img, tags) ->
      img.addEventListener 'load', () ->
        ratio_x = img.clientWidth / img.naturalWidth
        ratio_y = img.clientHeight / img.naturalHeight

        for tag in tags
          tag.style.left = tag.dataset.x * ratio_x + 'px'
          tag.style.top = tag.dataset.y * ratio_y + 'px'

document.addEventListener event, ziltag_sticker for event in ['DOMContentLoaded', 'page:load']