$(document).on('ready page:load', function(){
  if(document.body.dataset.controller == 'photos' && document.body.dataset.action == 'index'){
    
    
  }
});

$(window).on('load page:load', function(){
  
  if(document.body.dataset.controller == 'photos' && document.body.dataset.action == 'index'){
    // 貼上灰色sticker
    $("article[data-ziltag-sticker-article]").each(function(){
      ZiltagSticker.appendOtherZiltags( $(this), $(this).find("#all_ziltaggings").html());
    });
    
  
  }
  
});

