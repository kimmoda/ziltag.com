class Profile
  constructor: (@element) ->
    @avatar_wrapper = @element.querySelector '.profile__wrapper'
    @avatar_input = @element.querySelector '.profile__avatar-input'
    @avatar = @element.querySelector '.profile__avatar'
    @links = @element.querySelectorAll '.profile__link'
    @init()

  init: ->
    @avatar_wrapper.addEventListener 'click', => @avatar_input.click()
    @avatar_input.addEventListener 'change', =>
      if @avatar_input.files && @avatar_input.files[0]
        reader = new FileReader()
        reader.onload = (e) => @avatar.style.backgroundImage = "url(#{e.target.result})"
        reader.readAsDataURL @avatar_input.files[0]
    for link in @links
      link.addEventListener 'click', (event) ->
        @.parentElement.classList.toggle 'hide'
        @.parentElement.nextElementSibling.classList.toggle 'hide'

componentHandler.register
  constructor: Profile
  classAsString: 'Profile'
  cssClass: 'js-profile'