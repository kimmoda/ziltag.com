# ref: https://developer.mozilla.org/en-US/docs/Web/Events/scroll
throttle = (type, name, obj) ->
  obj = obj || window
  running = false
  func = ->
    return if running
    running = true
    requestAnimationFrame ->
      obj.dispatchEvent(new CustomEvent(name))
      running = false;
  obj.addEventListener(type, func)

throttle('scroll', 'optimizedScroll')