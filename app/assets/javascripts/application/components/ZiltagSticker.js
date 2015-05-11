var ZiltagSticker = {
  place:{
    x: 0,
    y: 0
  },
  
  move_direction: "",
  default_width: 300,
  default_height: 300,
  
  appendImg: function(){
    var that = this;
    $("article[data-ziltag-sticker-article]").each(function(){
      
      // Step1：圖片寬、高比較大小
      if( that.compareSide(parseInt($(this).outerWidth()), parseInt($(this).outerHeight())) ){
        
        // Step2：縮放的比例
        var ratio = that.calculateRatio( $(this).children("img[data-show-sticker]").width() );
        $(this).children("img[data-show-sticker]").css("width", that.default_width);
        
        that.move_direction = "vertical";
      }else{
      
        // Step2：縮放的比例
        var ratio = that.calculateRatio( $(this).children("img[data-show-sticker]").height() );
        $(this).children("img[data-show-sticker]").css("height", that.default_width);
        
        that.move_direction = "horizontal";
      }
      
      that.place.x = $(this).children("img[data-show-sticker]").data("ziltag-x") * ratio;
      that.place.y = $(this).children("img[data-show-sticker]").data("ziltag-y") * ratio;
      
      
      
      // Step3：樂貼位置
      that.stickerPos( $(this) );
      
      // Step4：移動圖片
      if( that.move_direction == "vertical" ){
        var move = that.place.y - that.default_height;
        if( move >= 0){
          
          if( (parseInt($(this).outerHeight()) - that.place.y) <= that.default_height){
            $(this).css({
              bottom: "0px"
            });
          }else{
            $(this).css({
              top: "-" + ((that.default_height/2) + move) + "px"
            });
          }
          
        }
      }
      if( move_direction == "horizontal" ){
        var move = that.place.x - that.default_width;
        if( move >= 0){
          
          
          if( (parseInt($(this).outerWidth()) - that.place.x) <= that.default_width){
            $(this).css({
              right: "0px"
            });
          }else{
            $(this).css({
              left: "-" + ((that.default_width/2) + move) + "px"
            });
          }
          
          
        }
      }
      
      
    });
    
  },
  
  // 比較寬、高，哪個數值較大
  compareSide: function(width, height){
    if (width <= height){
      return true;
    }
    return false;
  },
  
  // 計算比例
  calculateRatio: function(side_length){
    if( this.move_direction == "vertical" ){
      return (this.default_width / side_length);
    }
    return (this.default_height / side_length);
  },
  
  // 樂貼位置
  stickerPos: function(theElement){
    $(theElement).find("img[data-sticker]").css({
      left: this.place.x,
      top: this.place.y
    }).removeClass("hidden");
  }
  
}