document.addEventListener 'DOMContentLoaded', ->
  @sticker_container = document.querySelector '.sticker-container'
  @edit_mode_button = document.querySelector '.js-edit-mode-button'
  @normal_mode_button = document.querySelector '.js-normal-mode-button'

  @edit_mode_button?.addEventListener 'click', =>
    @sticker_container.classList.add 'sticker-container--edit-mode'
  @normal_mode_button?.addEventListener 'click', =>
    @sticker_container.classList.remove 'sticker-container--edit-mode'