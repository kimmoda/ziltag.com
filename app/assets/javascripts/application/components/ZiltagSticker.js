var ZiltagSticker = {
  place:{
    x: 0,
    y: 0
  },
  
  appendImg: function(){
    $("article[data-ziltag-sticker-article]").each(function(){
      
      this.x = $(this).children("img[data-show-sticker]").data("ziltag-x");
      this.y = $(this).children("img[data-show-sticker]").data("ziltag-y");
      
      $(this).find("img[data-sticker]").css({
        left: this.x,
        top: this.y
      }).removeClass("hidden");
      
    });
    
  },
  
}