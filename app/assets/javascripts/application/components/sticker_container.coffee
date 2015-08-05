class StickerContainer
  constructor: (@block) ->
    @image = @block.getElementsByClassName('sticker-container__image')[0]
    @stickers = @block.getElementsByClassName('sticker-container__sticker')
    @image.addEventListener 'load', @_on_image_load
  move_stickers: () ->
    ratio_x = @image.clientWidth / @image.naturalWidth
    ratio_y = @image.clientHeight / @image.naturalHeight
    for sticker in @stickers
      sticker.style.left = sticker.dataset.x * ratio_x + 'px'
      sticker.style.top = sticker.dataset.y * ratio_y + 'px'
  _on_image_load: () => @move_stickers()

document.addEventListener 'DOMContentLoaded', ->
  new StickerContainer block for block in document.getElementsByClassName('sticker-container')

document.addEventListener 'DOMNodeInserted', (e) ->
  if e.target.nodeType == Node.ELEMENT_NODE
    if e.target.classList.contains('sticker-container') then new StickerContainer e.target
    else new StickerContainer block for block in e.target.getElementsByClassName('sticker-container')