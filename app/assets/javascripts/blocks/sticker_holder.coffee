class @StickerHolder
  constructor: (@element) ->
    @image = @element.parentNode.querySelector '.sticker-container__image'
    @dismiss = @element.querySelector '.js-sticker-container__dismiss'
    @init()

  init: ->
    imagesLoaded @image, @update_coord
    if @dismiss
      @dismiss.addEventListener 'click', @hide

  update_coord: =>
    ratio_x = @image.clientWidth / @image.naturalWidth
    ratio_y = @image.clientHeight / @image.naturalHeight
    @element.style.left = @element.dataset.x * ratio_x + 'px'
    @element.style.top = @element.dataset.y * ratio_y + 'px'
    @element.classList.remove 'sticker-container__holder--hide'

  move: (x, y) ->
    @element.dataset.x = x
    @element.dataset.y = y
    @update_coord()

  hide: =>
    @element.classList.add 'sticker-container__holder--hide'

componentHandler.register
  constructor: StickerHolder
  classAsString: 'StickerHolder'
  cssClass: 'js-sticker-holder'