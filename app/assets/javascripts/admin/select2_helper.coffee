$(document).on 'ready page:load', () ->
  $('[data-select2-resource]').each (index, element) ->
    $element = $(element)
    resource = element.dataset.select2Resource
    text = element.dataset.select2Text
    id = element.dataset.select2Id
    $element.select2
      templateSelection: (data) -> data[text] || data.text
      templateResult: (data) -> data[text] || data.text
      theme: 'bootstrap'
      width: 'style'
      ajax:
        url: "/admin/#{resource}.json"
        data: (params) ->
          q: params.term
          page: params.page
        processResults: (data, params) -> data