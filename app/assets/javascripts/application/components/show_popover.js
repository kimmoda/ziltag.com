// 顯示 popover

$(document).on('ready page:load', function(){
  
  if( $("[data-component=show_popover]").length > 0 ){
    $("[data-component=show_popover]").popover();
  }

});

$(window).on('load page:load', function(){
});