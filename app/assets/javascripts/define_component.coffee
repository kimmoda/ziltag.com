window.define_component = (class_name, fn) ->
  # update_all = -> fn i for i in document.getElementsByClassName(class_name)
  $(document).on 'ready page:load', ->
    fn i for i in document.getElementsByClassName(class_name)
  # window.addEventListener 'resize', update_all
  # document.addEventListener 'DOMNodeInserted', (e) ->
  #   if e.target.nodeType == Node.ELEMENT_NODE
  #     if e.target.classList.contains(class_name) then fn e.target
  #     else if items = e.target.getElementsByClassName(class_name) then fn i for i in items 