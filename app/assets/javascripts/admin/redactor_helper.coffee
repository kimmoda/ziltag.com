$(document).on 'ready page:load', () ->
  $('[data-redactor]').redactor
    lang: 'zh_tw'
    imageUpload: '/redactor/images'
    uploadImageFields:
      authenticity_token: document.querySelector('meta[name="csrf-token"]').content