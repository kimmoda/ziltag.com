# 此檔案定義了 data-follow-user 與 data-follow-user-cancel，需要兩兩成對使用，例：
# <a class="btn btn-default btn-xs follow_user" data-follow-user>關注用戶</a>
# <a class="btn btn-default btn-xs follow_user cancel" data-follow-user-cancel>取消追蹤</a>
$(document).on 'ready page:load', () ->
  $('body').on 'ajax:success', '[data-follow-user]', () ->
    $(this).hide().siblings('[data-follow-user-cancel]').show()
  $('body').on 'ajax:success', '[data-follow-user-cancel]', () ->
    $(this).hide().siblings('[data-follow-user]').show()