$(document).on 'ready page:load', () ->
  $('[data-select2-resource]').each (index, element) ->
    $element = $(element)
    resource = element.dataset.select2Resource
    $element.select2
      ajax:
        url: "/admin/#{resource}.json"
        data: (params) ->
          q: params.term
          page: params.page
        processResults: (data, params) -> data