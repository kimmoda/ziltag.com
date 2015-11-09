class PlatformSection
  constructor: (@element) ->
    @platforms = @element.querySelectorAll '.platform-section__platform'
    @currentBrandImage = @element.querySelector '.platform-section__current-brand-img'

    @init()

  init: ->
    platform.addEventListener 'click', @onClickPlatform for platform in @platforms

  onClickPlatform: (event) =>
    @displayForm event.currentTarget.dataset.form
    @currentBrandImage.src = @element.querySelector("[data-form='#{event.currentTarget.dataset.form}'] > img").src
    for platform in @platforms
      platform.classList.toggle 'platform-section__platform--selected', platform == event.currentTarget

  displayForm: (name) ->
    for form in @element.querySelectorAll('form')
      form.classList.toggle 'hide',  form.id != "#{name}_form"

componentHandler.register
  constructor: PlatformSection
  classAsString: 'PlatformSection'
  cssClass: 'js-platform-section'