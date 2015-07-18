// 切換樂貼或留言

main(function(){
  if( $("[data-component=tag_or_msg]").length > 0 ){
    $("[data-component=tag_or_msg]").find("button").each(function(){

      $(this).on("click", function(){

        if( $(this).hasClass("show_ziltag") ){
          $(this).closest("[data-component=tag_or_msg]").find("button.show_ziltag").addClass("active");
          $(this).closest("[data-component=tag_or_msg]").find("button.show_comments").removeClass("active");

          $(this).closest("article.post_ziltag_article").find("div.get_comments_block").addClass("hidden");

          $(this).closest("article.post_ziltag_article").find("div.ziltag_wrapper").find("a").removeClass("hidden");
          $(this).closest("article.post_ziltag_article").find("div.parent_comment").addClass("hidden");
        }
        if( $(this).hasClass("show_comments") ){
          $(this).closest("[data-component=tag_or_msg]").find("button.show_ziltag").removeClass("active");
          $(this).closest("[data-component=tag_or_msg]").find("button.show_comments").addClass("active");

          $(this).closest("article.post_ziltag_article").find("div.get_comments_block").removeClass("hidden");

          $(this).closest("article.post_ziltag_article").find("div.ziltag_wrapper").find("a").addClass("hidden");
          $(this).closest("article.post_ziltag_article").find("div.parent_comment").removeClass("hidden");
        }
      });

    });
  }
});


$(window).on('load page:load', function(){
});
