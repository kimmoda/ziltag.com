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
    @element.insertAdjacentHTML 'beforeend', """
    <div class="sticker-container__holder js-sticker-holder sticker-container__holder--hide new-holder" data-x="#{x}" data-y="#{y}">
      <div class="sticker-container__circle"></div>
      <div class="sticker-container__dialog dialog js-dialog">
        <div class="dialog__frame">
          <form action="/stickers" method="post">
            <div class="mdl-textfield mdl-js-textfield">
              <textarea class="mdl-textfield__input" type="text" id="content"></textarea>
              <label class="mdl-textfield__label" for="content">What's in your mind?</label>
            </div>
          </form>
        </div>
        <div class="dialog__arrow"></div>
      </div>
    </div>
    """
    @new_holder = @element.lastChild
    componentHandler.upgradeElements @new_holder

componentHandler.register
  constructor: StickerContainer
  classAsString: 'StickerContainer'
  cssClass: 'js-sticker-container'