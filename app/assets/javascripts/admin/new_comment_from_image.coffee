# 用於在圖片上點擊座標後重導至新增留言頁
# <img src="blablabla" data-new-comment="/admin/comments/new">
$(document).on 'ready page:load', () ->
  $('img[data-new-comment]').click (e) ->
    window.location.href = URI(this.dataset.newComment).search
      image_url: URI(this.src).absoluteTo(window.location.href).normalize()
      x: e.offsetX
      y: e.offsetY