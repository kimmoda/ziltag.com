class StickerContainer
  constructor: (@element) ->
    @image = @element.querySelector '.sticker-container__image'
    @holders = @element.getElementsByClassName 'sticker-container__holder'
    @new_holder = @element.querySelector '.new-holder'
    @dismiss = @element.querySelector '.sticker-container__dismiss'
    @current_holder = @element.querySelector '.sticker-container__holder--current'
    @init()

  init: ->
    imagesLoaded @image, @update_holders
    @image.addEventListener 'click', @_image_clicked
    @dismiss.addEventListener 'click', => @new_holder.style.display = ''

  update_holders: =>
    for holder in @holders
      @move_holder holder, holder.dataset.x, holder.dataset.y

  move_holder: (holder, x, y) ->
    holder.style.left = x*100 + '%'
    holder.style.top = y*100 + '%'
    holder.style.display = 'inherit' unless holder.classList.contains 'new-holder'

  _image_clicked: (e) =>
    e.stopPropagation()
    e.stopImmediatePropagation()
    [data_x, data_y] = @_coord(e)
    if @element.classList.contains 'sticker-container--edit-mode'
      if @current_holder
        @move_holder(@current_holder, data_x, data_y)
        document.querySelector('.js-edit-textarea').focus()
        form = document.querySelector '.js-edit-form'
        @update_field_value form, data_x, data_y
    else
      if @new_holder
        @move_holder(@new_holder, data_x, data_y)
        @new_holder.style.display = 'inherit'
        @new_holder.addEventListener 'transitionend', => @new_holder.querySelector('textarea').focus()
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