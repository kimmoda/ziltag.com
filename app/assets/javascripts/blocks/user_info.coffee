class UserInfo
  constructor: (@element) ->
    @share_link = @element.querySelector '.user-info__share-link'
    @init()

  init: ->
    @share_link.addEventListener 'click', ->
      window.prompt('The URL of this page is below. Copy it to easily share with friends.', this.dataset.link);

componentHandler.register
  constructor: UserInfo
  classAsString: 'UserInfo'
  cssClass: 'js-user-info'