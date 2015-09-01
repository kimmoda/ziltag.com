class Dialog
  constructor: (@element) ->
    @textarea = @element.getElementsByTagName('textarea')[0]
    @init()

  init: ->
    @textarea.addEventListener 'keyup', @_on_keyup

  _on_keyup: =>
    @textarea.style.height = 0
    @textarea.style.height = (10 + @textarea.scrollHeight) + "px"

componentHandler.register
  constructor: Dialog
  classAsString: 'Dialog'
  cssClass: 'js-dialog'