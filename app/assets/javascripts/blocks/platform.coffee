class Platform
  constructor: (@element) ->
    @buttons = @element.querySelectorAll('.platform__item')
    @fields = @element.querySelectorAll('.platform__input')
    @type = @element.querySelector('.platform__type-field')
    @init()
  init: ->
    for button in @buttons
      button.addEventListener 'click', (e) =>
        i.classList.remove('platform__item--selected') for i in @buttons
        e.target.classList.add('platform__item--selected')
        field = @element.querySelector e.target.dataset.selector
        for i in @fields
          i.classList.add('hide')
          i.setAttribute('disabled', 'disabled')
        field.removeAttribute('disabled')
        field.classList.remove('hide')
        @type.value = e.target.dataset.type

componentHandler.register
  constructor: Platform
  classAsString: 'Platform'
  cssClass: 'js-platform'