class StickerHolder
  constructor: (@element) ->
    @image = @element.parentNode.getElementsByClassName('sticker-container__image')[0]
    @init()
  init: ->
    imagesLoaded @image, =>
      ratio_x = @image.clientWidth / @image.naturalWidth
      ratio_y = @image.clientHeight / @image.naturalHeight
      @element.style.left = @element.dataset.x * ratio_x + 'px'
      @element.style.top = @element.dataset.y * ratio_y + 'px'
      @element.classList.remove 'sticker-container__holder--hide'

componentHandler.register
  constructor: StickerHolder
  classAsString: 'StickerHolder'
  cssClass: 'js-sticker-holder'