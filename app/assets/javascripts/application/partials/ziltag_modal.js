// 樂貼滑進的特效
$(document).on('ready page:load', function(){
  
  if(document.body.dataset.controller == 'pages' && document.body.dataset.action == 'home'){
    
    // 滑出視窗的版面控制
    allJs.data_ziltag_modal_layout("close");
    
    $('a.btn_remove').on('click', function(e){
      e.preventDefault();
      allJs.data_ziltag_modal_layout_back($(this));
    });
    
    $('[data-ziltag-modal]').on('ajax:success', function(event, data){
      console.log(data); //TODO
      
      $("[data-user-username]").html(data.user.username);
      $("[data-user-avatar]").attr("src", data.user.avatar);
      $("[data-post-title]").html(data.post.title);
      $("[data-post-content]").html(data.post.content);
      //$("[data-modal-post-ziltag-article]").find("[data-ziltag-x]").attr("data-ziltag-x", data.x);
      //$("[data-modal-post-ziltag-article]").find("[data-ziltag-y]").attr("data-ziltag-y", data.y);
      
      $("[data-modal-post-ziltag-article]").find("[data-show-sticker]").attr("data-ziltag-x", data.x).attr("data-ziltag-y", data.y)
      
      // 貼上sticker
      ZiltagSticker.appendImg();
      
      // 動態從右至左跑出
      allJs.data_ziltag_modal_layout_after_click();
      
    });
    
  }
  
  
});

$(window).resize(function(){
  
  // 滑出視窗的版面控制
  allJs.data_ziltag_modal_layout("open");
  
});