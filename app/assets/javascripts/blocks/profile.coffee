class Profile
  constructor: (@element) ->
    @avatar_wrapper = @element.querySelector '.profile__wrapper'
    @avatar_input = @element.querySelector '.profile__avatar-input'
    @avatar = @element.querySelector '.profile__avatar'
    # @edit = @avatar.querySelector '.profile__edit'
    @init()

  init: ->
    @avatar_wrapper.addEventListener 'click', => @avatar_input.click()
    @avatar_input.addEventListener 'change', =>
      if @avatar_input.files && @avatar_input.files[0]
        reader = new FileReader()
        reader.onload = (e) => @avatar.style.backgroundImage = "url(#{e.target.result})"
        reader.readAsDataURL @avatar_input.files[0]

componentHandler.register
  constructor: Profile
  classAsString: 'Profile'
  cssClass: 'js-profile'