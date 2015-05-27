$(document).on 'ready page:load', () ->
  if document.body.dataset.controller == 'photos' && document.body.dataset.action == 'index'
    container = document.querySelector('section.photos_index')
    imagesLoaded container, () ->
      msnry = new Masonry container, {
        columnWidth: 300
        gutter: 10
        itemSelector: '.item'
      }