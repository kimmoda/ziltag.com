// 按了直接滑到上方

main(function(){
  if( $("[data-component=scroll_top]").length > 0 ){
    $("[data-component=scroll_top]").on("click", function(){
      $('html, body').animate({
        scrollTop: 0
      }, 750);
      
      $(this).closest("[data-modal-post-ziltag-article]").animate({
        scrollTop: 0
      }, 750);
      
    });
  }
});


$(window).on('load page:load', function(){
});