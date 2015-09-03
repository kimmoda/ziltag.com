document.addEventListener 'DOMContentLoaded', ->
  if document.querySelector 'body.pages.home'
    url_field =  document.querySelector '#image_url'
    upload_button = document.querySelector '.or-upload__upload'
    file_field = document.querySelector 'input[type="file"]'
    form = document.querySelector '#new_photo'
    upload_button.addEventListener 'click', -> file_field.click()
    file_field.addEventListener 'change', -> form.submit()
