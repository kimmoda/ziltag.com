run_in 'photos', 'index', () ->
  container = document.querySelector('section.photos_index')
  imagesLoaded container, () ->
    msnry = new Masonry container, {
      columnWidth: 300
      gutter: 10
      itemSelector: '.ziltag_wrapper'
    }