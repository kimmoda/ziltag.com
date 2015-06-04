// 置換樂貼顯示模組裡面的內容

main(function(){
  $(document).on('ajax:success', '[data-ziltag-replace]', function(event, data){
    ZiltagSticker.replaceModalData(data, this);
  });
});