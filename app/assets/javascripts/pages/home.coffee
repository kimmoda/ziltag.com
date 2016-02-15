`var Tracker = require('../tracker.js')`
document.addEventListener 'DOMContentLoaded', ->
  if document.querySelector('body.pages.home') || document.querySelector('body.pages.register')
    BG_ORIGIN_WIDTH = 1366
    BG_ORIGIN_HEIGHT = 768
    layout = document.querySelector('.mdl-layout')
    player = document.querySelector('.layout__player')
    landing = document.querySelector('.layout__landing')
    screen_ratio = document.body.clientHeight / document.body.clientWidth
    image_ratio  = BG_ORIGIN_HEIGHT / BG_ORIGIN_WIDTH
    if image_ratio > screen_ratio
      scaled_width = document.body.clientWidth
      scaled_height = BG_ORIGIN_HEIGHT * (scaled_width/BG_ORIGIN_WIDTH)
    else
      scaled_height = document.body.clientHeight
      scaled_width = BG_ORIGIN_WIDTH * (scaled_height/BG_ORIGIN_HEIGHT)
    x_ratio = scaled_width / BG_ORIGIN_WIDTH
    y_ratio = scaled_height / BG_ORIGIN_HEIGHT
    player.style.left = (630 * x_ratio) + 'px'
    player.style.top = (168 * y_ratio) + 'px'
    player.width = 555 * x_ratio
    player.height = 310 * y_ratio
    landing.style.left = (50 * x_ratio) + 'px'
    landing.style.top = (190 * y_ratio) + 'px'
    landing.style.transform = "scale(#{x_ratio}, #{y_ratio})"

    on_player = false

    window.addEventListener 'blur', ->
      if on_player
        Tracker.record 'video-0'
        setTimeout (->
          Tracker.record 'video-1'
        ), 28000

        setTimeout (->
          Tracker.record 'video-2'
        ), 53000

        setTimeout (->
          Tracker.record 'video-3'
        ), 78000

        setTimeout (->
          Tracker.record 'video-4'
        ), 105000

    player.addEventListener 'mouseover', ->
       on_player = true

    player.addEventListener 'mouseout', ->
        on_player = false
