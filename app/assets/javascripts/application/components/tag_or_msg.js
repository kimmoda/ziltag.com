// 切換樂貼或留言

$(document).on('ready page:load', function(){
  
  if( $("[data-component=tag_or_msg]").length > 0 ){
    $("[data-component=tag_or_msg]").find("button").each(function(){
      
      $(this).on("click", function(){
        $(this).closest("[data-component=tag_or_msg]").find("button").toggleClass("active");
      });
      
    });
  }

});

$(window).on('load page:load', function(){
});