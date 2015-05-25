# 此檔案定義了 data-precious 與 data-precious-cancel，需要兩兩成對使用，例：
# <a href="#" class="btn_precious" data-precious data-post-id="ID"><i class="fa fa-star"></i></a>
# <a href="#" class="btn_precious cancel" data-precious-cancel data-post-id="ID"><i class="fa fa-star"></i></a>
toggle = (post_id, action) ->
  data_post_id = "[data-post-id=\"#{post_id}\"]"
  data_precious = "#{data_post_id}[data-precious]"
  data_precious_cancle = "#{data_post_id}[data-precious-cancel]"
  switch action
    when 'collect'
      $(data_precious).hide()
      $(data_precious_cancle).show()
    when 'uncollect'
      $(data_precious_cancle).hide()
      $(data_precious).show()

$(document).on 'ready page:load', () ->
  $('body').on 'ajax:success', '[data-precious]', () ->
    toggle(this.dataset.postId, 'collect')
  $('body').on 'ajax:success', '[data-precious-cancel]', () ->
    toggle(this.dataset.postId, 'uncollect')