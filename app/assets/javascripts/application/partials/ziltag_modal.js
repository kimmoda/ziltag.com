// 樂貼滑進的特效
$(document).on('ready page:load', function(){
  
  if(document.body.dataset.controller == 'pages' && document.body.dataset.action == 'home'){
    
    // 滑出視窗的版面控制
    allJs.data_ziltag_modal_layout();
    
    $('a[data-btn-remove]').on('click', function(e){
      e.preventDefault();
      window.history.replaceState(null, null, "/");
      allJs.data_ziltag_modal_layout_back($(this));
    });
    
    
    
  }
  x
  
});

$(window).load(function(){
  
  if(document.body.dataset.controller == 'pages' && document.body.dataset.action == 'home'){
    // 貼上sticker
    ZiltagSticker.appendImgOnModal();
  }
  
});

$(window).resize(function(){
  
  if(document.body.dataset.controller == 'pages' && document.body.dataset.action == 'home'){
    // 滑出視窗的版面控制
    allJs.data_ziltag_modal_layout();
    
    // 貼上sticker
    ZiltagSticker.appendImgOnModal();
  }
  
});

window.addEventListener("popstate", function(e) {
  window.history.replaceState(null, null, "/");
  allJs.data_ziltag_modal_layout_back($('a[data-btn-remove]'));
});