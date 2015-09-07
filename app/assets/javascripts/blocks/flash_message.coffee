class FlashMessage
  constructor: (@element) ->
    @init()

  init: ->
    setTimeout =>
      @element.classList.add 'animated', 'fadeOutDown'
    , 3000

componentHandler.register
  constructor: FlashMessage
  classAsString: 'FlashMessage'
  cssClass: 'js-flash-message'