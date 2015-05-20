// 樂貼滑進的特效
$(document).on('ready page:load', function(){
  // TODO: 重複點擊相同的文章，會重複發送請求索取 JSON 資料，可以在第一次發送時就 cache 結果，減輕伺服器負擔。
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