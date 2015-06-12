# 收藏文章按鈕
# <a href="#" class="collect UNIQUE_CLASS" data-class="UNIQUE_CLASS"><i class="fa fa-star"></i></a>
# <a href="#" class="uncollect UNIQUE_CLASS" data-class="UNIQUE_CLASS"><i class="fa fa-star"></i></a>
toggle = (klass, action) ->
  target = ".#{klass}"
  the_collected = document.querySelectorAll "a.collect#{target}"
  the_uncollected = document.querySelectorAll "a.uncollect#{target}"
  switch action
    when 'collect'
      collected.style.display = 'none' for collected in the_collected
      uncollected.style.display = '' for uncollected in the_uncollected
    when 'uncollect'
      uncollected.style.display = 'none' for uncollected in the_uncollected
      collected.style.display = '' for collected in the_collected

main () ->
  $(document.body).on 'ajax:success', 'a.collect', () ->
    toggle(this.dataset.class, 'collect')
  $(document.body).on 'ajax:success', 'a.uncollect', () ->
    toggle(this.dataset.class, 'uncollect')