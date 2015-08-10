class StickerContainer
  constructor: (@block) ->
    @image = @block.getElementsByClassName('sticker-container__image')[0]
    @stickers = @block.getElementsByClassName('sticker-container__sticker')
    imagesLoaded @image, @_on_image_load
  fetch_stickers: ->
    fetch "/api/v1/ziltaggings?source=#{encodeURIComponent(@image.src)}"
    .then (response) -> response.json()
    .then (json) =>
      frag = document.createDocumentFragment()
      for sticker in json
        div = document.createElement 'div'
        div.classList.add 'sticker-container__sticker'
        div.dataset.id = sticker.id
        div.dataset.x = sticker.x
        div.dataset.y = sticker.y
        frag.appendChild div
      @block.appendChild frag
      @move_stickers()
  move_stickers: () ->
    ratio_x = @image.clientWidth / @image.naturalWidth
    ratio_y = @image.clientHeight / @image.naturalHeight
    for sticker in @stickers
      sticker.style.left = sticker.dataset.x * ratio_x + 'px'
      sticker.style.top = sticker.dataset.y * ratio_y + 'px'
  _on_image_load: () =>
    if @block.hasAttribute 'data-remote' then @fetch_stickers() else @move_stickers()

define_component 'sticker-container', (e) -> new StickerContainer e