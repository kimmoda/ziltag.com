# `[data-ziltag-model]`

用於 `a[data-remote]` 上，點擊後展開樂貼。

```html
<a href="/ziltaggings/1.json" data-remote data-ziltag-model></a>
```

# `.ziltag_wrapper`、`.ziltag_sticker`

用於將樂貼顯示在圖片上。

```html
<div class="ziltag_wrapper">
  <img src="">
  <a class="ziltag_sticker" data-x="10" data-y="10"></a>
  <a class="ziltag_sticker" data-x="10" data-y="390"></a>
  <a class="ziltag_sticker" data-x="190" data-y="390"></a>
  <a class="ziltag_sticker" data-x="190" data-y="10"></a>
  <a class="ziltag_sticker" data-x="17" data-y="332"></a>
  ...
</div>
```

相關檔案：

- `app/assets/stylesheets/application/ziltag_sticker.scss`
- `app/assets/javascripts/application/ziltag_sticker.coffee`