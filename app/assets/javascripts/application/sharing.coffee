### 分享按鈕
<li class="share_item">
  <a href="#"></a>
  <div>
    <img src="" alt="">
    <ul>
      <li><a href="#" class="icon_share fb"><i class="fa fa-facebook-square fa-2x"></i></a></li>
      <li><a href="#" class="icon_share twitter"><i class="fa fa-twitter-square fa-2x"></i></a></li>
      <li><a href="#" class="icon_share tumblr"><i class="fa fa-tumblr-square fa-2x"></i></a></li>
      <li><a href="#" class="icon_share googleplus"><i class="fa fa-google-plus-square fa-2x"></i></a></li>
      ...
    </ul>
  </div>
</li>
###

main () ->
  for li in document.getElementsByClassName('share_item')
    do (li) ->
      btn = li.getElementsByTagName('a')[0]
      popup = li.getElementsByTagName('div')[0]
      btn.addEventListener 'click', (e) ->
        e.preventDefault()
        popup.style.display = if popup.style.display == 'unset' then '' else 'unset'