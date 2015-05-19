$(document).on('ready page:load', function(){
  if(document.body.dataset.controller == 'photos' && document.body.dataset.action == 'index'){
    
    
  }
});

$(window).on('load page:load', function(){
  
  if(document.body.dataset.controller == 'photos' && document.body.dataset.action == 'index'){
    // 貼上灰色sticker
    ZiltagSticker.appendOtherZiltags($("article[data-ziltag-sticker-article]"), $("article[data-ziltag-sticker-article]").find("#all_ziltaggings").html());
  
  }
  
});

