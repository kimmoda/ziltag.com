#  監聽 'DOMContentLoaded' 與 'page:load' 的懶人寫法。
window.main = (fn) ->
  document.addEventListener 'DOMContentLoaded', fn
  document.addEventListener 'page:load', fn

# 所有 class 擁有 `class_name` 的元件都會以次數的形式傳遞給 `fn` 執行，
# 動態增加的元件亦如是。
window.define_component = (class_name, fn) ->
  main () ->
    document.addEventListener 'DOMNodeInserted', (e) ->
      if e.target.nodeType == Node.ELEMENT_NODE
        if e.target.classList?.contains?(class_name) then fn e.target
        else fn i for i in items if items = e.target?.getElementsByClassName?(class_name)
    for root_element in document.getElementsByClassName(class_name)
      fn root_element

routes = {}

# `fn` 只有在指定的 `controller` 與 `action` 下才會執行
window.run_in = (controller, action, fn) ->
  routes[controller] ||= {}
  routes[controller][action] = fn

main () ->
  routes[document.body.dataset.controller]?.init?()
  routes[document.body.dataset.controller]?[document.body.dataset.action]?()