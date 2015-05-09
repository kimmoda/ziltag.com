$(document).on('ready page:load', function(){
  $('a[data-target=#signupModal]').on('click', function(e){
    e.preventDefault();
  });
});