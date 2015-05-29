# 點擊展開樂貼

用於 `a[data-ziltag-modal]` 上，點擊後展開樂貼。

```html
<a href="/ziltaggings/1.json" data-remote data-ziltag-modal></a>
```

# 顯示圖片與樂貼

```html
<div class="ziltag_wrapper">
  <img src="">
  <a data-x="10" data-y="10"></a>
  <a data-x="10" data-y="390"></a>
  <a data-x="190" data-y="390"></a>
  <a data-x="190" data-y="10"></a>
  <a data-x="17" data-y="332"></a>
  ...
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
<a href="#" class="collect" data-post-id="ID"><i class="fa fa-star"></i></a>
<a href="#" class="uncollect" data-post-id="ID"><i class="fa fa-star"></i></a>
```