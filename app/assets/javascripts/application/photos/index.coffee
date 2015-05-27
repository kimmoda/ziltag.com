photos_index = () ->
  return unless document.body.dataset.controller == 'photos' && document.body.dataset.action == 'index'
  container = document.querySelector('section.photos_index')
  imagesLoaded container, () ->
    msnry = new Masonry container, {
      columnWidth: 300
      gutter: 10
      itemSelector: '.item'
    }
document.addEventListener event, photos_index for event in ['DOMContentLoaded', 'page:load']