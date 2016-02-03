class ScriptTextarea
  constructor: (@element) ->
    @init()
  init: ->
    @element.addEventListener 'copy', (event) ->
      Tracker.record 'text-copy'
componentHandler.register
  constructor: ScriptTextarea
  classAsString: 'ScriptTextarea'
  cssClass: 'js-script-textarea'