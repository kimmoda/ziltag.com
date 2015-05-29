main(function(){
  var modal = document.getElementById('ziltag_modal');
  var section_post = document.querySelector('[data-layout="col_right"]');
  function show(){
    var rect = section_post.getBoundingClientRect();
    modal.style.left = rect.left + 'px';
    modal.style.width = document.body.clientWidth - rect.left + 'px';
  };
  window.addEventListener('resize', show);
});