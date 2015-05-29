# 收藏文章按鈕
# <a href="#" class="collect" data-post-id="ID"><i class="fa fa-star"></i></a>
# <a href="#" class="uncollect" data-post-id="ID"><i class="fa fa-star"></i></a>
toggle = (post_id, action) ->
  data_post_id = "[data-post-id=\"#{post_id}\"]"
  the_collected = document.querySelectorAll "a.collect#{data_post_id}"
  the_uncollected = document.querySelectorAll "a.uncollect#{data_post_id}"
  switch action
    when 'collect'
      collected.style.display = 'none' for collected in the_collected
      uncollected.style.display = '' for uncollected in the_uncollected
    when 'uncollect'
      uncollected.style.display = 'none' for uncollected in the_uncollected
      collected.style.display = '' for collected in the_collected

main () ->
  $(document.body).on 'ajax:success', 'a.collect', () ->
    toggle(this.dataset.postId, 'collect')
  $(document.body).on 'ajax:success', 'a.uncollect', () ->
    toggle(this.dataset.postId, 'uncollect')