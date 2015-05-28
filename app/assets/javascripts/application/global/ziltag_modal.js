// 樂貼滑進的特效
$(document).on('ready page:load', function(){
  
  // 滑出視窗的版面控制
  allJs.data_ziltag_modal_layout();
  
  if( $("[data-ziltag-modal]").length > 0 ){
    $('a[data-btn-remove]').attr("data-back-path", location.pathname);
    
    $('a[data-btn-remove]').on('click', function(e){
      e.preventDefault();
      //window.history.replaceState(null, null, "/");
      window.history.back();
      allJs.data_ziltag_modal_layout_back();
    });
    
    // TODO: 重複點擊相同的文章，會重複發送請求索取 JSON 資料，可以在第一次發送時就 cache 結果，減輕伺服器負擔。
    $('[data-ziltag-modal]').on('ajax:success', function(event, data){
      // 置換內容
      ZiltagSticker.replaceModalData(data);
      
      // 貼上sticker
      ZiltagSticker.appendImgOnModal();
      ZiltagSticker.appendOtherZiltags($("article[data-ziltag-sticker-article][data-is-modal='true']"), JSON.stringify(data.other_ziltaggings), true, false, false);
      
      // 動態從右至左跑出
      allJs.data_ziltag_modal_layout_after_click();
      
    });
  }

});

$(window).load(function(){
  
  if( $("[data-ziltag-modal]").length > 0 ){
    // 貼上sticker
    ZiltagSticker.appendImgOnModal();
  }
  
});

$(window).resize(function(){
  
  // 滑出視窗的版面控制
  allJs.data_ziltag_modal_layout();
  
  if( $("[data-ziltag-modal]").length > 0 ){
    // 貼上sticker
    ZiltagSticker.appendImgOnModal();
  }
  
});

window.addEventListener("popstate", function(e) {
  window.history.replaceState(null, null, $('a[data-btn-remove]').attr("data-back-path"));
  allJs.data_ziltag_modal_layout_back();
});