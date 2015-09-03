document.addEventListener 'DOMContentLoaded', ->
  upload_button = document.querySelector '.or-upload__upload'
  file_field = document.querySelector 'input[type="file"]'
  form = document.querySelector '#new_photo'
  upload_button.addEventListener 'click', -> file_field.click()
  file_field.addEventListener 'change', -> form.submit()