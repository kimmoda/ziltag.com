# 此檔案定義了 data-precious 與 data-precious-cancel，需要兩兩成對使用，例：
# <a href="#" class="btn_precious" data-precious data-post-id="ID"><i class="fa fa-star"></i></a>
# <a href="#" class="btn_precious cancel" data-precious-cancel data-post-id="ID"><i class="fa fa-star"></i></a>
toggle = (post_id, action) ->
  data_post_id = "[data-post-id=\"#{post_id}\"]"
  preciouss = document.querySelectorAll "#{data_post_id}[data-precious]"
  precious_cancles = document.querySelectorAll "#{data_post_id}[data-precious-cancel]"
  switch action
    when 'collect'
      precious.style.display = 'none' for precious in preciouss
      precious_cancle.style.display = '' for precious_cancle in precious_cancles
    when 'uncollect'
      precious_cancle.style.display = 'none' for precious_cancle in precious_cancles
      precious.style.display = '' for precious in preciouss

main () ->
  $(document.body).on 'ajax:success', '[data-precious]', () ->
    toggle(this.dataset.postId, 'collect')
  $(document.body).on 'ajax:success', '[data-precious-cancel]', () ->
    toggle(this.dataset.postId, 'uncollect')