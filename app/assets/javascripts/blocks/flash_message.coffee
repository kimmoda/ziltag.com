class FlashMessage
  constructor: (@element) ->
    @init()

  init: ->
    setTimeout =>
      @element.classList.add 'animated', 'fadeOutUp'
    , 4000

componentHandler.register
  constructor: FlashMessage
  classAsString: 'FlashMessage'
  cssClass: 'js-flash-message'