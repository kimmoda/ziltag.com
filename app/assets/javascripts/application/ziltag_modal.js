// 樂貼滑進的特效
$(document).on('ready page:load', function(){
  $('[data-ziltag-modal]').on('ajax:success', function(event, data){
    console.log(data); //TODO
  });
});