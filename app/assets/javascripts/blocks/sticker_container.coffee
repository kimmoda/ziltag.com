class StickerContainer
  constructor: (@block) ->
    @image = @block.getElementsByClassName('sticker-container__image')[0]
    @holders = @block.getElementsByClassName('sticker-container__holder')
    imagesLoaded @image, @_on_image_load
  move_holders: () ->
    ratio_x = @image.clientWidth / @image.naturalWidth
    ratio_y = @image.clientHeight / @image.naturalHeight
    for holder in @holders
      holder.style.left = holder.dataset.x * ratio_x + 'px'
      holder.style.top = holder.dataset.y * ratio_y + 'px'
      holder.classList.remove 'sticker-container__holder--hide'
  _on_image_load: () => @move_holders()

define_component 'sticker-container', (e) -> new StickerContainer e