# 樂貼點擊的行為

- `data-ziltag-modal`：滑出
- `data-ziltag-replace`：取代當前樂貼顯示模組的內容

```html
<a href="/ziltaggings/1.json" data-remote data-ziltag-modal></a>
<a href="/ziltaggings/1.json" data-remote data-ziltag-replace></a>
```

# 顯示圖片與樂貼

參考：http://codepen.io/tonytonyjan/pen/mJRrwR

```html
<div class="ziltag_wrapper">
  <img src="">
  <a data-x="10" data-y="10"></a>
  <a data-x="10" data-y="390"></a>
  <!-- 加上 .active  變成紅色 -->
  <a data-x="190" data-y="390" class="active"></a>
  <a data-x="190" data-y="10"></a>
  <a data-x="17" data-y="332"></a>
  ...
</div>
```

# 在 300x300 範圍內顯示圖片與一個樂貼

只要在 `.ziltag_wrapper` 外面包一層 `.ziltag_thumb` 即可使用，會依照比例縮放填滿 300x300，並且移動到樂貼出現的位置。

參考：http://codepen.io/tonytonyjan/pen/KpNjQv/

```html
<div class="ziltag_thumb">
  <div class="ziltag_wrapper">
    <img src="">
    <a href="#" data-x="350" data-y="150"></a>
  </div>
</div>
```


# 分享按鈕

```html
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
```

# 追蹤按鈕

```html
<a class="follow" data-leader-id="ID">關注用戶</a>
<a class="unfollow" data-leader-id="ID">取消追蹤</a>
```

# 收藏按鈕

```html
<a href="#" class="collect UNIQUE_CLASS" data-class="UNIQUE_CLASS"><i class="fa fa-star"></i></a>
<a href="#" class="uncollect UNIQUE_CLASS" data-class="UNIQUE_CLASS"><i class="fa fa-star"></i></a>
```

# 分享按鈕

```html
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
```

# 樂貼顯示模組

```html
<!-- modal：呈現空的模板，資料透過 JS 塞入 -->
<%= render 'partials/ziltag_article', type: :modal %>

<!-- 獨立頁：資料透過 server 塞入 -->
<%= render 'partials/ziltag_article', type: :page %>
```