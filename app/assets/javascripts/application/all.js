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
    
    // 調整 aside.aside 的高度
    $("aside[data-layout=aside]").css("height", $("div[data-layout=col_right]").outerHeight() + "px");
    
    $('header.header').affix({
      offset: {
        top: 25
      }
    });
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
  
  // 滑出視窗的動畫排版
  data_ziltag_modal_layout: function(){
    
    var the_width = $("div[data-layout=col_right]").width() + (( $(window).width() - $("div[data-layout=inner]").width() ) / 2);
    
    if( $("article[data-modal-post-ziltag-article]").attr("data-modal-status") == "close"){
      $("article[data-modal-post-ziltag-article]").css({
        "width": the_width + "px",
        "height": ($(window).height() - 70) + "px",
        "right": - the_width + "px"
      });
    }
    
    if( $("article[data-modal-post-ziltag-article]").attr("data-modal-status") == "open" ){
      $("article[data-modal-post-ziltag-article]").css({
        "width": the_width + "px",
        "height": ($(window).height() - 70) + "px",
        "right": "0px"
      });
    }
    
  },
  // 動態從右至左跑出
  data_ziltag_modal_layout_after_click: function(){
    
    if( $("article[data-modal-post-ziltag-article]").attr("data-modal-status") == "close" ){
      $("article[data-modal-post-ziltag-article]").attr("data-modal-status", "open");
    }
    
    $("article[data-modal-post-ziltag-article]").animate({
      "right": "0px"
    });
    
    $("body").css({
      "overflow": "hidden"
    });
  },
  // 動態從右至左跑出
  data_ziltag_modal_layout_back: function(theElement){
    if( $("article[data-modal-post-ziltag-article]").attr("data-modal-status") == "open" ){
      $("article[data-modal-post-ziltag-article]").attr("data-modal-status", "close");
    }
    $("article[data-modal-post-ziltag-article]").animate({
      "right":  - $(theElement).closest("article[data-modal-post-ziltag-article]").width() + "px"
    });
    
    $("body").css({
      "overflow": "auto"
    });
  },
};