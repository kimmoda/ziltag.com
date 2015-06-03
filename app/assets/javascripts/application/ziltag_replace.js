// 置換樂貼顯示模組裡面的內容

main(function(){
  $(document).on('ajax:success', '[data-ziltag-replace]', function(event, data){
    ZiltagSticker.replaceModalData(data);
    this.classList.add('active');
    other_a_tags = this.parentNode.getElementsByTagName('a');
    for(var i = 0; i < other_a_tags.length; i++)
      if(other_a_tags[i] !== this) other_a_tags[i].classList.remove('active');
  });
});