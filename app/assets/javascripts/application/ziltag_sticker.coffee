ziltag_sticker = () ->
  imagesLoaded document.body, () ->
    for wrapper in document.querySelectorAll('[data-ziltag-wrapper]')
      img = wrapper.querySelector('img')
      ratio_x = img.clientWidth / img.naturalWidth
      ratio_y = img.clientHeight / img.naturalHeight

      tags = wrapper.querySelectorAll('a[data-ziltag-sticker]')
      for tag in tags
        tag.style.left = tag.dataset.x * ratio_x + 'px'
        tag.style.top = tag.dataset.y * ratio_y + 'px'

document.addEventListener event, ziltag_sticker for event in ['DOMContentLoaded', 'page:load']