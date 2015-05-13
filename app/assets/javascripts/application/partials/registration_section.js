$(document).on('ready page:load', function(){
  $("button[data-trigger-select-image], div[data-profile-img-block]").on('click', function(){
    $(this).closest("div[data-form-photo]").find("input[data-profile-input]").click();
  });
  
  $("input[data-profile-input]").change(function(){
    allJs.readURL(this);
  });
});