run_in 'pages', 'home', ->
  scroll_to_bottom (page) ->
    $.get '/', page: page, scroll: true, q: location.search.match(/[&?]q=([^&]*)/)?[1], (data) ->
      section = document.getElementsByClassName('section_post')[0]
      section.insertAdjacentHTML 'beforeend', data