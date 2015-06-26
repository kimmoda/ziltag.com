// profile 收藏頁的輪播

main(function(){

  if( $("body").is(".users.collecting") ){
    $('div.show_slick').slick({
      infinite: false,
      slidesToShow: 16,
      slidesToScroll: 16
    });

    $("a.square_image").on("click", function(e){
      e.preventDefault();

      var source   = $("#handlebar_ziltag_thumb_show_one").html();
      var template = Handlebars.compile(source);
      var context = {
        image_url: $(this).data("image-url"),
        x: $(this).data("x"),
        y: $(this).data("y"),
        link: $(this).data("link")
      };
      var html    = template(context);
      $(this).closest(".post_article").find("article.c_ziltag_sticker_article").html(html);

    });
  }

});


$(window).on('load page:load', function(){
});
