window.define_component = (class_name, fn) ->
  document.addEventListener 'DOMContentLoaded', ->
    document.addEventListener 'DOMNodeInserted', (e) ->
      if e.target.nodeType == Node.ELEMENT_NODE
        if e.target.classList.contains(class_name) then fn e.target
        # else fn i for i in items if items = e.target.getElementsByClassName(class_name)
    fn i for i in document.getElementsByClassName(class_name)