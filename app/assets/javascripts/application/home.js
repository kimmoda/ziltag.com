$(document).on('ready page:load', function(){
  if(document.body.dataset.controller == 'pages' && document.body.dataset.action == 'home'){
    
    
    $('a.btn_share').on('click', function(e){
      e.preventDefault();
      $(this).closest("li").find("div[data-share-zone]").toggleClass("hidden");
    });
    
    
  }
});

$(window).load(function(){
  
  if(document.body.dataset.controller == 'pages' && document.body.dataset.action == 'home'){
    // 貼上sticker
    ZiltagSticker.appendImg();
  }
  
});

