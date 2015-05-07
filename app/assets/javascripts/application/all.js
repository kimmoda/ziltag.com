var allJs = {
  
  // 調整layout的介面
  tune_layout: function(){
    
    // 針對 div[data-layout=outer_fill_white] 的留白區
    if( $(window).width() < 768 ){
      var left_side_width = 50;
    }else{
      var left_side_width = ($(window).width() - $("div[data-layout=inner]").width()) / 2;
    }
    $("div[data-layout=outer]").children("div[data-layout=outer_fill_white]").css("width", left_side_width + "px");
    
    // 針對 div[data-layout=custom_header_line] 分隔線
    var col_right = $("div[data-layout=col_right]").outerWidth();
    $("div[data-layout=custom_header_line]").css("width", (col_right + left_side_width) + "px");
  },
};