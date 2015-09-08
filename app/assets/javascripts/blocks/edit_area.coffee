class EditArea
  constructor: (@element) ->
    @textarea = @element.querySelector '.edit-area__field > textarea'
    @init()

  init: ->
    @textarea.addEventListener 'keyup', @_update_textare_height
    @textarea.addEventListener 'keydown', @_check_submit

  _update_textare_height: =>
    @textarea.style.height = 0
    @textarea.style.height = (10 + @textarea.scrollHeight) + 'px'

  _check_submit: (e) =>
    @element.submit() if (e.ctrlKey || e.metaKey) && e.keyCode == 13

componentHandler.register
  constructor: EditArea
  classAsString: 'EditArea'
  cssClass: 'js-edit-area'