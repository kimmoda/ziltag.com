# 用於在圖片上顯示留言
# <img src="blablabla" data-comment-sticker>
$(document).on 'ready page:load', () ->
  $imgs = $('img[data-comment-sticker]')
  return if $imgs.length == 0
  url_hash = {}
  image_urls = for img in $imgs
    url = URI(img.src).absoluteTo(window.location.href).normalize().href()
    url_hash[url] ||= []
    url_hash[url].push img
    url
  $.getJSON '/admin/comments.json', image_url: image_urls, root: false, (response) ->
    comments = response.results
    for comment in comments
      for img in url_hash[comment.image_url]
        $img = $(img)
        $img.wrap('<div style="position:relative;" data-wrapper="true"></div>') unless $img.parent().data('wrapper')
        $img.after("<div style=\"position:absolute;left:#{comment.x}px;top:#{comment.y}px;\"><div class=\"comment_sticker\"><img src=\"#{comment.avatar}\" width=\"20px\"/> #{comment.text}</div></div>")