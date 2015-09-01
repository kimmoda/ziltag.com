class @StickerHolder
  constructor: (@element) ->
    @image = @element.parentNode.getElementsByClassName('sticker-container__image')[0]
    @init()
  init: ->
    imagesLoaded @image, @update_coord

  update_coord: =>
      ratio_x = @image.clientWidth / @image.naturalWidth
      ratio_y = @image.clientHeight / @image.naturalHeight
      @element.style.left = @element.dataset.x * ratio_x + 'px'
      @element.style.top = @element.dataset.y * ratio_y + 'px'
      @element.classList.remove 'sticker-container__holder--hide'

  move: (x, y)->
    @element.dataset.x = x
    @element.dataset.y = y
    @update_coord()

componentHandler.register
  constructor: StickerHolder
  classAsString: 'StickerHolder'
  cssClass: 'js-sticker-holder'