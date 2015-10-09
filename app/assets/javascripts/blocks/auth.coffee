class Auth
  constructor: (@element) ->
    @login = @element.querySelector('.auth__login')
    @signup = @element.querySelector('.auth__signup')
    console.log @signup
    @login_btn = @element.querySelector('.auth__login-btn')
    @signup_btn = @element.querySelector('.auth__signup-btn')
    @init()
  init: ->
    @login_btn.addEventListener 'click', =>
      @login.classList.remove 'hide'
      @signup.classList.add 'hide'
    @signup_btn.addEventListener 'click', =>
      @login.classList.add 'hide'
      @signup.classList.remove 'hide'
    
componentHandler.register
  constructor: Auth
  classAsString: 'Auth'
  cssClass: 'js-auth'