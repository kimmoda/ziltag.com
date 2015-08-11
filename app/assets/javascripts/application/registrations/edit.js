main(function(){

  if( $("body").is(".registrations.edit, .registrations.update") ){
    // 頭像
    $("a.img_profile_link").on("click", function(e){
      e.preventDefault();
      $("input.select_profile_file").click();
    });
    $("input.select_profile_file").change(function(){
      var selectedFile = this;
      if (selectedFile.files && selectedFile.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
          $("img.img_profile_tag").attr('src', e.target.result);
          fetch('/users', {
            method: 'post',
            credentials: 'same-origin',
            body: new FormData(document.getElementById('profile_form'))
          });
        }
        reader.readAsDataURL(selectedFile.files[0]);
      }
    });

    // banner
    $("div.user_banner").on("click", function(e){
      e.preventDefault();
      $("input.select_banner_file").click();
    });
    $("input.select_banner_file").change(function(){
      var selectedFile = this;
      if (selectedFile.files && selectedFile.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
          $("img.user_banner_img").attr('src', e.target.result);
          fetch('/users', {
            method: 'post',
            credentials: 'same-origin',
            body: new FormData(document.getElementById('profile_form'))
          });
        }
        reader.readAsDataURL(selectedFile.files[0]);
      }
    });
  }


});
