class @StickerHolder
  constructor: (@element) ->
    @image = @element.parentNode.querySelector '.sticker-container__image'
    @dismiss = @element.querySelector '.js-holder-dismiss'
    @init()

  init: ->
    imagesLoaded @image, @update_coord
    if @dismiss
      @dismiss.addEventListener 'click', @hide

  update_coord: =>
    @element.style.left = @element.dataset.x*100 + '%'
    @element.style.top = @element.dataset.y*100 + '%'
    @show() unless @element.classList.contains 'new-holder'
    @

  move: (x, y) ->
    @element.dataset.x = x
    @element.dataset.y = y
    @update_coord()
    @

  show: =>
    @element.classList.remove 'sticker-container__holder--hide'
    @

  hide: =>
    @element.classList.add 'sticker-container__holder--hide'
    @

componentHandler.register
  constructor: StickerHolder
  classAsString: 'StickerHolder'
  cssClass: 'js-sticker-holder'