// 樂貼滑進的特效

var ziltag_modal = {
  modal:'',
  section_post: ''
};

function showPostModal(){
  var rect = ziltag_modal.section_post.getBoundingClientRect();
  ziltag_modal.modal.style.left = rect.left + 'px';
  ziltag_modal.modal.style.width = document.body.clientWidth - rect.left + 'px';
  $("body").css({
    "overflow": "hidden"
  });
};

main(function(){
  
  ziltag_modal.modal = document.getElementById('ziltag_modal');
  ziltag_modal.section_post = document.querySelector('[data-layout="col_right"]');
  
  
  $('a[data-btn-remove]').attr("data-back-path", location.pathname);
  
  $('a[data-btn-remove]').on('click', function(e){
    e.preventDefault();
    window.history.back();
    ziltag_modal.modal.style.left = '100%';
    $("body").css({
      "overflow": "auto"
    });
    $("[data-modal-post-ziltag-article]").attr("data-modal-status", "close");
  });
  
  // TODO: 重複點擊相同的文章，會重複發送請求索取 JSON 資料，可以在第一次發送時就 cache 結果，減輕伺服器負擔。
  $('[data-ziltag-modal]').on('ajax:success', function(event, data){
    
    $("[data-modal-post-ziltag-article]").attr("data-modal-status", "open");
    
    // 置換內容
    ZiltagSticker.replaceModalData(data);
    
    ZiltagSticker.appendImgOnModal(data);
    
    showPostModal();
    
  });
  
});


$(window).resize(function(){
  
  if( $("[data-modal-post-ziltag-article]").attr("data-modal-status") == "open" ){
    showPostModal();
  }
  
});

window.addEventListener("popstate", function(e) {
  window.history.replaceState(null, null, $('a[data-btn-remove]').attr("data-back-path"));
});