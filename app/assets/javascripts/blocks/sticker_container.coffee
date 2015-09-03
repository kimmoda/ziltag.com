class StickerContainer
  constructor: (@element) ->
    @image = @element.parentNode.querySelector('.sticker-container__image')
    @new_holder = @element.querySelector('.new-holder')
    @init()

  init: ->
    @image.addEventListener 'click', @_on_click

    @new_holder.addEventListener 'transitionend', (e) =>
      if e.target == @new_holder && e.propertyName == 'left'
        @new_holder.querySelector('textarea').focus()

    form = @new_holder.getElementsByTagName('form')[0]
    form.addEventListener 'submit', =>
      form.querySelector('input[name="sticker[x]"]').value = @new_holder.dataset.x
      form.querySelector('input[name="sticker[y]"]').value = @new_holder.dataset.y

  _on_click: (e) =>
    [data_x, data_y] = @_coord(e)
    if @new_holder
      @new_holder['StickerHolder'].move(data_x, data_y).show()
      @new_holder.querySelector('textarea').focus()

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

componentHandler.register
  constructor: StickerContainer
  classAsString: 'StickerContainer'
  cssClass: 'js-sticker-container'