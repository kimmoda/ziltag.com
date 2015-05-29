// 顯示 popover

main(function(){
  if( $("[data-component=show_popover]").length > 0 ){
    $("[data-component=show_popover]").popover();
  }
});

$(window).on('load page:load', function(){
});