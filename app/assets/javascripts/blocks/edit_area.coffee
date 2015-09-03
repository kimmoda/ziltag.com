class EditArea
  constructor: (@element) ->
    @textarea = @element.querySelector '.edit-area__field > textarea'
    @init()

  init: ->
    @textarea.addEventListener 'keyup', @update_textare_height

  update_textare_height: =>
    @textarea.style.height = 0
    @textarea.style.height = (10 + @textarea.scrollHeight) + 'px'

componentHandler.register
  constructor: EditArea
  classAsString: 'EditArea'
  cssClass: 'js-edit-area'