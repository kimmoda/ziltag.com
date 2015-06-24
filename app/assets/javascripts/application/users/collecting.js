// profile 收藏頁的輪播

main(function(){
  
  if( $("body").is(".users.collecting") ){
    $('div.show_slick').slick({
      infinite: false,
      slidesToShow: 8,
      slidesToScroll: 8
    });
  }
  
});


$(window).on('load page:load', function(){
});