class Profile
  constructor: (@element) ->
    @avatar = @element.querySelector '.profile__avatar'
    # @edit = @avatar.querySelector '.profile__edit'
    @init()

  init: ->
    # @avatar.addEventListener 'mouseover', =>
    #   @edit.style.visibility = 'inherit'
    # @avatar.addEventListener 'mouseout', => @edit.style.visibility = ''
    # @avatar.addEventListener 'click', => @input.click()
    # @input.addEventListener 'change', =>
    #   if @input.files && @input.files[0]
    #     reader = new FileReader()
    #     reader.onload = (e) => @img.src = e.target.result
    #     reader.readAsDataURL @input.files[0]
    #     fetch '/api/v1/users',
    #       method: 'put'
    #       body: new FormData(@form)
    #       credentials: 'same-origin'

componentHandler.register
  constructor: Profile
  classAsString: 'Profile'
  cssClass: 'js-profile'