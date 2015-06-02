var allJs = {
  
  // 調整layout的介面
  tune_layout: function(){
    
    // 針對 div[data-layout=outer_fill_white] 的留白區
    if( $(window).width() < 768 ){
      var left_side_width = 0;
    }else{
      var left_side_width = ($(window).width() - $("div[data-layout=inner]").width()) / 2;
    }
    
    // 針對 div[data-layout=custom_header_line] 分隔線
    var col_right = $("div[data-layout=col_right]").outerWidth();
    $("div[data-layout=custom_header_line]").css("width", (col_right + left_side_width + 1) + "px");
    
    // 調整 aside.aside 的高度及寬度
    $("aside[data-layout=aside]").css("height", ($(window).height() - 60) + "px");
    if( $(window).width() < 768 ){
      $("aside[data-layout=aside]").css({
        "padding-left": left_side_width + "px",
        "width": ( 30 + $("div[data-layout=col_logo]").width() ) + "px"
      });
    }else{
      $("aside[data-layout=aside]").css({
        "padding-left": left_side_width + "px",
        "width": ( left_side_width + $("div[data-layout=col_logo]").width() ) + "px"
      });
    }
    
    
  },
  
  // 選擇圖片預覽圖
  readURL: function(selectedFile) {
    if (selectedFile.files && selectedFile.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        
        $("button[data-trigger-select-image]").addClass("hidden");
        $("div[data-profile-img-block]").removeClass("hidden");
        
        $('img[' + $(selectedFile).data("target") + ']').attr('src', e.target.result);
      }
      reader.readAsDataURL(selectedFile.files[0]);
    }
  },
  
};