// 樂貼滑進的特效
$(document).on('ready page:load', function(){

  $('[data-ziltag-modal]').on('ajax:success', function(event, data){
    // 置換內容
    ZiltagSticker.replaceModalData(data);
    
    // 貼上sticker
    ZiltagSticker.appendImgOnModal();
    ZiltagSticker.appendOtherZiltags($("article[data-ziltag-sticker-article][data-is-modal='true']"), JSON.stringify(data.other_ziltaggings), false);
    
    // 動態從右至左跑出
    allJs.data_ziltag_modal_layout_after_click();
    
  });

});