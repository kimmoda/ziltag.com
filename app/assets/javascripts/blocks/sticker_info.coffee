class StickerInfo
  constructor: (@element) ->
    @editor_button = @element.querySelector '.sticker-info__editor-button'
    @dismiss_button = @element.querySelector '.sticker-info__dismiss-button'
    @editor_pane = @element.querySelector '.sticker-info__editor-pane'
    @status_pane = @element.querySelector '.sticker-info__status-pane'
    @textarea = @element.querySelector 'textarea'
    @init()

  init: ->
    @editor_button?.addEventListener 'click', @_on_editor_click
    @dismiss_button?.addEventListener 'click', @_on_dismiss_click

  _on_editor_click: =>
    @editor_pane.classList.remove 'hide'
    @status_pane.classList.add 'hide'
    @textarea.focus() if @textarea
  _on_dismiss_click: =>
    @editor_pane.classList.add 'hide'
    @status_pane.classList.remove 'hide'

componentHandler.register
  constructor: StickerInfo
  classAsString: 'StickerInfo'
  cssClass: 'js-sticker-info'