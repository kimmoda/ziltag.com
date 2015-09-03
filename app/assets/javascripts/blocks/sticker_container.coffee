class StickerContainer
  constructor: (@element) ->
    @image = @element.parentNode.getElementsByClassName('sticker-container__image')[0]
    @init()
  init: -> @image.addEventListener 'click', @_on_click

  _on_click: (e) =>
    [data_x, data_y] = @_coord(e)
    if @new_holder then @new_holder['StickerHolder'].move(data_x, data_y)
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

  _put_holder: (x, y) ->
    @element.insertAdjacentHTML 'beforeend', """
    <div class="sticker-container__holder js-sticker-holder sticker-container__holder--hide new-holder" data-x="#{x}" data-y="#{y}">
      <div class="sticker-container__circle"></div>
      <div class="sticker-container__dialog dialog">
        <div class="dialog__frame">
          <form action="/stickers" method="post" class="edit-area js-edit-area">
            <div class="edit-area__field mdl-textfield mdl-js-textfield">
              <textarea name="sticker[content]" class="edit-area__textarea mdl-textfield__input" type="text" id="content" autofocus required></textarea>
              <label class="mdl-textfield__label" for="content">What's in your mind?</label>
            </div>
            <input type="hidden" name="sticker[x]" value="#{x}">
            <input type="hidden" name="sticker[y]" value="#{y}">
            <input type="hidden" name="sticker[photo_id]" value="#{@image.dataset.id}">
            <input type="hidden" name="authenticity_token" value="#{document.querySelector('meta[name=csrf-token]').content}">
            <input type="submit" class="mdl-button mdl-js-button mdl-button--accent" value="Save Message">
          </form>
          <button class="js-sticker-container__dismiss dialog__dismiss mdl-button mdl-js-button mdl-button--icon">
            <i class="material-icons">clear</i>
          </button>
        </div>
        <div class="dialog__arrow"></div>
      </div>
    </div>
    """
    @new_holder = @element.lastChild
    componentHandler.upgradeElements @new_holder
    @new_holder.addEventListener 'transitionend', (e) =>
      if e.target == @new_holder && e.propertyName == 'left'
        @new_holder.querySelector('textarea').focus()

    form = @new_holder.getElementsByTagName('form')[0]
    form.addEventListener 'submit', =>
      form.querySelector('input[name="sticker[x]"]').value = @new_holder.dataset.x
      form.querySelector('input[name="sticker[y]"]').value = @new_holder.dataset.y

componentHandler.register
  constructor: StickerContainer
  classAsString: 'StickerContainer'
  cssClass: 'js-sticker-container'