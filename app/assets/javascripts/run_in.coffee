routes = {}

window.main = (fn) -> document.addEventListener event, fn for event in ['DOMContentLoaded', 'page:load']

window.run_in = (controller, action, fn) ->
  routes[controller] ||= {}
  routes[controller][action] = fn

main () ->
  routes[document.body.dataset.controller]?.init?()
  routes[document.body.dataset.controller]?[document.body.dataset.action]?()