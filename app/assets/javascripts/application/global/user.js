// 記錄使用者的資訊
var user = {
  id: null,
  login_status: false
};

main(function(){

  if( $("li[data-user-id]").data("user-id") != undefined ){
    user.id = $("li[data-user-id]").data("user-id");
    user.username = $("li[data-user-id]").data("user-username");
    user.login_status = true;
  }
});
