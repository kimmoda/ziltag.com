$(document).on('ready page:load', function(){
  if(document.body.dataset.controller == 'ziltaggings' && document.body.dataset.action == 'show'){
    ZiltagSticker.appendImg();
    ZiltagSticker.appendOtherZiltags($("article[data-ziltag-sticker-article]"), $("#other_ziltaggings").html());
  }
});
 
$(window).load(function(){
  
  if(document.body.dataset.controller == 'ziltaggings' && document.body.dataset.action == 'show'){
    // 貼上sticker
    ZiltagSticker.appendImg();
    ZiltagSticker.appendOtherZiltags($("article[data-ziltag-sticker-article]"), $("#other_ziltaggings").html());
  }
  
});

$(window).resize(function(){
  
  if(document.body.dataset.controller == 'ziltaggings' && document.body.dataset.action == 'show'){
    // 貼上sticker
    ZiltagSticker.appendImg();
    ZiltagSticker.appendOtherZiltags($("article[data-ziltag-sticker-article]"), $("#other_ziltaggings").html());
  }
  
});