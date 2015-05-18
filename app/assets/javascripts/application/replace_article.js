// data-replace-article
// 用於點擊灰色樂貼時，置換內容
$(document).on('ready page:load', function(){
  $('[data-modal-post-ziltag-article]').on('ajax:success', '[data-replace-article]', function(e, data){
    console.log(data); // TODO
  });
});