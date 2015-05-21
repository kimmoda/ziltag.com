$(document).on 'ready page:load', () ->
  $('[data-select2-resource]').each (index, element) ->
    $element = $(element)
    resource = element.dataset.select2Resource
    $element.select2
      templateSelection: (data) -> data.text
      templateResult: (data) -> data.text
      theme: 'bootstrap'
      width: 'style'
      ajax:
        url: "/admin/select2/#{resource}"
        data: (params) ->
          q: params.term
          page: params.page
        processResults: (data, params) -> data