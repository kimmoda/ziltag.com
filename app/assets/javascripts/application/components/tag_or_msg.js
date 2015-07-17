// 切換樂貼或留言

main(function(){
  if( $("[data-component=tag_or_msg]").length > 0 ){
    $("[data-component=tag_or_msg]").find("button").each(function(){

      $(this).on("click", function(){
        $(this).closest("[data-component=tag_or_msg]").find("button").toggleClass("active");
        $(this).closest("article.post_ziltag_article").find("div.get_comments_block").toggleClass("hidden");

        $(this).closest("article.post_ziltag_article").find("div.ziltag_wrapper").find("a").toggleClass("hidden");
        $(this).closest("article.post_ziltag_article").find("div.parent_comment").toggleClass("hidden");

        if( $(this).hasClass("show_ziltag") ){

        }
        if( $(this).hasClass("show_comments") ){
        }
      });

    });
  }
});


$(window).on('load page:load', function(){
});
