# 用於在圖片上點擊座標後重導至新增樂貼頁
# <img src="blablabla" data-new-post="/admin/posts/new">
$(document).on 'ready page:load', () ->
  $('img[data-new-post]').click (e) ->
    target = URI(this.dataset.newPost).search
      image_url: URI(this.src).absoluteTo(window.location.href).normalize()
      x: e.offsetX
      y: e.offsetY
    window.location.href = target