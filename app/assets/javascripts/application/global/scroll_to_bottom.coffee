# 捲動載入
window.scroll_to_bottom = (fn) ->
  page = 1
  window.addEventListener 'optimizedScroll', ->
    scrollTop = document.documentElement?.scrollTop || document.body.scrollTop
    scrolledToBottom = (scrollTop + window.innerHeight) >= document.body.scrollHeight
    fn(page+=1) if scrolledToBottom