$(document).on('ready page:load', function(){
  if(document.body.dataset.controller == 'photos' && document.body.dataset.action == 'show'){
    
    
  }
});

$(window).on('load page:load', function(){
  
  if(document.body.dataset.controller == 'photos' && document.body.dataset.action == 'show'){
    
    // 貼上灰色sticker
    $("article[data-ziltag-sticker-article]").each(function(){
      ZiltagSticker.appendOtherZiltags( $(this), $(this).find("#all_ziltaggings").html(), true);
    });
    
    // 滑鼠移過樂貼換圖
    $(document).on('mouseover', 'li[data-ziltagging-id]', function(){
      $(this).closest("[data-photo-article]").find("a[data-ziltag-id=" + $(this).data("ziltagging-id") + "]").children("img").attr("src", "<%= asset_path('ziltag_sticker.png') %>");
    });
    $(document).on('mouseout', 'li[data-ziltagging-id]', function(){
      $(this).closest("[data-photo-article]").find("a[data-ziltag-id=" + $(this).data("ziltagging-id") + "]").children("img").attr("src", "<%= asset_path('ziltag_sticker_others.png') %>");
    });
    
  }
  
});

$(window).resize(function(){
  if(document.body.dataset.controller == 'photos' && document.body.dataset.action == 'show'){
    
    if( $(window).width() > 1200 || $(window).width() <= 1200 || $(window).width() <= 992 || $(window).width() <= 768 ){
      $("[data-ziltag-link]").remove();
      $("article[data-ziltag-sticker-article]").each(function(){
        ZiltagSticker.appendOtherZiltags( $(this), $(this).find("#all_ziltaggings").html(), true);
      });
    }
    
  }
});