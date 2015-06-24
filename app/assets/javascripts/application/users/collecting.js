// profile 收藏頁的輪播

main(function(){
  
  $('div.show_slick').slick({
    infinite: true,
    slidesToShow: 3,
    slidesToScroll: 3
  });
  
});


$(window).on('load page:load', function(){
});