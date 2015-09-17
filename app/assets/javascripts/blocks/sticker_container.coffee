class StickerContainer
  constructor: (@element) ->
    @image = @element.parentNode.querySelector '.sticker-container__image'
    @new_holder = @element.querySelector '.new-holder'
    @current_holder = @element.querySelector '.sticker-container__holder--current'
    @init()

  init: ->
    @image.addEventListener 'click', @_on_click

  _on_click: (e) =>
    e.stopPropagation()
    e.stopImmediatePropagation()
    [data_x, data_y] = @_coord(e)
    if @element.classList.contains 'sticker-container--edit-mode'
      if @current_holder
        @current_holder['StickerHolder'].move(data_x, data_y)
        document.querySelector('.js-edit-textarea').focus()
        form = document.querySelector '.js-edit-form'
        @update_field_value form, data_x, data_y
    else
      if @new_holder
        @new_holder['StickerHolder'].move(data_x, data_y).show()
        @new_holder.querySelector('textarea').focus()
        form = @new_holder.querySelector 'form'
        @update_field_value form, data_x, data_y

  _coord: (e) ->
    body_rect = document.body.getBoundingClientRect()
    image_rect = @image.getBoundingClientRect()
    offset_x = image_rect.left - body_rect.left
    offset_y = image_rect.top - body_rect.top
    data_x = (e.pageX - offset_x) / @image.clientWidth
    data_y = (e.pageY - offset_y) / @image.clientHeight
    [data_x, data_y]

  update_field_value: (form, x, y) ->
    form.querySelector('input[name="ziltag[x]"]').value = x
    form.querySelector('input[name="ziltag[y]"]').value = y

  restore_current_holder: =>
    data_x = @current_holder.dataset.originX
    data_y = @current_holder.dataset.originY
    @current_holder['StickerHolder'].move(data_x, data_y)
    form = document.querySelector '.js-edit-form'
    @update_field_value form, data_x, data_y

componentHandler.register
  constructor: StickerContainer
  classAsString: 'StickerContainer'
  cssClass: 'js-sticker-container'