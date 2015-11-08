class Profile
  constructor: (@element) ->
    @avatar = @element.querySelector('.profile__avatar')
    @img = @avatar.querySelector('img')
    @input = @element.querySelector('.profile__avatar-input')
    @form = @element.querySelector('.avatar-form')
    @init()

  init: ->
    @avatar.addEventListener 'click', => @input.click()
    @input.addEventListener 'change', =>
      if @input.files && @input.files[0]
        reader = new FileReader()
        reader.onload = (e) => @img.src = e.target.result
        reader.readAsDataURL @input.files[0]
        fetch '/api/v1/users',
          method: 'put'
          body: new FormData(@form)
          credentials: 'same-origin'

componentHandler.register
  constructor: Profile
  classAsString: 'Profile'
  cssClass: 'js-profile'