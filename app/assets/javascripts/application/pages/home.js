$(window).on('load page:load', function(){
  
  if(document.body.dataset.controller == 'pages' && document.body.dataset.action == 'home'){
    // 貼上sticker
    ZiltagSticker.appendImg();
  }
  
});

