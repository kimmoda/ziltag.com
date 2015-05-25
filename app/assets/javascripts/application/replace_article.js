// data-replace-article
// 用於點擊灰色樂貼時，置換內容
$(document).on('ready page:load', function(){
  $('[data-modal-post-ziltag-article]').on('ajax:success', '[data-replace-article]', function(e, data){
    
    // 置換內容
    ZiltagSticker.replaceModalData(data);
    
    // 貼上sticker
    ZiltagSticker.appendImgOnModal();
    ZiltagSticker.appendOtherZiltags($("article[data-ziltag-sticker-article][data-is-modal='true']"), JSON.stringify(data.other_ziltaggings), true, false, false);
    
  });
});