class StickerContainer
  constructor: (@element) ->
    @image = @element.parentNode.getElementsByClassName('sticker-container__image')[0]
    @init()
  init: -> @image.addEventListener 'click', @_on_click

  _on_click: (e) =>
    [data_x, data_y] = @_coord(e)
    if @new_holder then @_move_holder data_x, data_y
    else @_put_holder data_x, data_y

  _coord: (e) ->
    body_rect = document.body.getBoundingClientRect()
    image_rect = @image.getBoundingClientRect()
    offset_x = image_rect.left - body_rect.left
    offset_y = image_rect.top - body_rect.top
    ratio_x = @image.naturalWidth / @image.clientWidth
    ratio_y = @image.naturalHeight / @image.clientHeight
    data_x = (e.pageX - offset_x)*ratio_x
    data_y = (e.pageY - offset_y)*ratio_y
    [data_x, data_y]
  CssClasses:
    NEW_HOLDER: 'new-holder'

  _remove_old_holder: ->
    for i in @element.getElementsByClassName @CssClasses.NEW_HOLDER
      i.parentNode.removeChild i

  _move_holder: (x, y)->
    new StickerHolder(@new_holder).move(x, y)

  _put_holder: (x, y) ->
    @new_holder = document.createElement 'div'
    circle = document.createElement 'div'

    @new_holder.classList.add 'sticker-container__holder', 'js-sticker-holder', 'sticker-container__holder--hide', @CssClasses.NEW_HOLDER
    @new_holder.dataset.x = x
    @new_holder.dataset.y = y
    @new_holder.addEventListener 'click', -> alert()
    circle.classList.add 'sticker-container__circle'

    @new_holder.appendChild circle
    @element.appendChild @new_holder

    componentHandler.upgradeElement @new_holder, 'StickerHolder'
    @_put_dialog()

  _put_dialog: ->
    @new_dialog = document.createElement 'div'
    frame = document.createElement 'div'
    arrow = document.createElement 'div'

    @new_dialog.classList.add 'sticker-container__dialog', 'dialog'
    frame.classList.add 'dialog__frame'
    arrow.classList.add 'dialog__arrow'

    @new_dialog.appendChild frame
    @new_dialog.appendChild arrow
    @new_holder.appendChild @new_dialog

componentHandler.register
  constructor: StickerContainer
  classAsString: 'StickerContainer'
  cssClass: 'js-sticker-container'