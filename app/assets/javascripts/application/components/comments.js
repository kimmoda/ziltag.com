// 留言功能

// 重新設定
var comment_reset = function(){
  $("button.show_ziltag").click();
  $(document).off("click", "span.original_text");
  $(document).off("click", "a.edit_children_comment");
  $(document).off("click", "[data-comments]");
  $(document).off("keyup", "input.leave_msg");
  $(document).off("click", "button.send_msg");
  $(document).off("click", "span.remove_comment");
  $(document).off("click", "span.original_text");
  $(document).off("mousedown", "div.parent_comment span.drag_comment");
  $("article.c_ziltag_sticker_article div.ziltag_wrapper").off("mousemove");
  $("article.c_ziltag_sticker_article").off("mouseup");
  $(document).off("click", "a.original_text_action_edit");
  $(document).off("keyup", "input.original_text_edit");
  $(document).off("blur", "input.original_text_edit");
  $(document).off("click", "a.edit_children_comment");
  $(document).off("keyup", "input.edit_this_children_comment");
  $(document).off("blur", "input.edit_this_children_comment");
  $(document).off("click", "a.delete_children_comment");
  $("article.post_ziltag_article a.old_comment, article.post_ziltag_article a.new_comment").off("click");
};

// 留言初始化
var comment_init = function(){
  if( $("[data-comments]").length > 0 ){

    // 新增留言的 obj
    var post_comment = {
      "comment": {
        "text": "",
        "comment_id": "",
        "x": "",
        "y": "",
        "email": "",
        "user_id": "",
        "photo_id": "",
      }
    };

    var comment_zone = $("[data-comments]");
    var comment_zone_img = $(comment_zone).find("img")[0];
    var photo_id = $(comment_zone_img).data("photo-id");
    var ratio = {};
    ratio.x = $(comment_zone_img)[0].clientWidth / $(comment_zone_img)[0].naturalWidth;
    ratio.y = $(comment_zone_img)[0].clientHeight / $(comment_zone_img)[0].naturalHeight;

    var get_all_comments = function(page, hidden_bool){

      // 取得所有該 photo 的留言
      $.ajax({
        url: '/comments.json?photo_id=' + photo_id + '&page=' + page,
        type: 'GET',
        data: "",
        dataType: 'json',
        success: function(data){
          $("div.parent_comment").remove();

          $("article.post_ziltag_article a.new_comment").attr("data-page", page - 1);
          if( data.more ){
            $("article.post_ziltag_article a.old_comment").attr("data-page", page + 1);
          }else{
            $("article.post_ziltag_article a.old_comment").attr("data-page", "-1");
          }

          $.each(data.results, function(index, obj){

              if( obj.user == null ){
                var user_id = "";
                var user_email = "";
                var user_name = "#";
                var avatar_thumb_url = "/images/fallback/thumb_guest.png";

              }else{
                var user_id = obj.user.id;
                var user_email = obj.user.email;
                var user_name = "/users/" + obj.user.username;
                var avatar_thumb_url = obj.user.avatar_thumb_url;
              }

              if( user.login_status ){ // 是否有登入
                var current_user_avatar = "";
              }else{
                var current_user_avatar = "/images/fallback/thumb_guest.png";
              }

              var source   = $("#handlebar_comment").html();
              var template = Handlebars.compile(source);
              var context = {
                x: obj.x,
                y: obj.y,
                comment_id: obj.id,
                pos_left: (obj.x * ratio.x),
                pos_top: (obj.y * ratio.y),
                user_id: user_id,
                user_email: user_email,
                user_name: user_name,
                user_avatar: avatar_thumb_url,
                first_msg: obj.text,
                current_user_avatar: current_user_avatar,
                login_user_id: user.id,
                login_status: user.login_status,
                hidden_bool: hidden_bool,
                children_comments: obj.children
              };
              var html    = template(context);

              $(comment_zone).closest("article.c_ziltag_sticker_article").prepend(html);
          });

        }
      });
    };
    get_all_comments(1, "hidden");


    // 在圖片上點擊，新增留言
    $(comment_zone).on("click", function(e){
      if( $(this).closest(".post_ziltag_article").find("button.show_comments").hasClass("active") ){
        $(".parent_comment").removeClass("z_index_plus");
        var comment_zone_img = $(this).find("img")[0];

        var relX = e.pageX - $(this).parent().offset().left;
        var relY = e.pageY - $(this).parent().offset().top;

        // 未依比例的原來x,y座標
        post_comment.comment.x = relX / ratio.x;
        post_comment.comment.y = relY / ratio.y;
        post_comment.comment.photo_id = $(comment_zone_img).data("photo-id");

        var source   = $("#handlebar_comment_create").html();
        var template = Handlebars.compile(source);
        var context = {
          pos_left: relX,
          pos_top: relY
        };
        var html    = template(context);

        $(comment_zone).closest("article.c_ziltag_sticker_article").append(html);
      }
    });


    // 按下 enter 鍵，送出 "新增留言"
    $(document).on("keyup", "input.leave_msg", function(e){
      if (e.keyCode == 13) {
        $(this).closest(".leave_msg_block").find("button.send_msg").click();
      }
    });
    // 按下發佈按鈕
    $(document).on("click", "button.send_msg", function(){

      var comment_text = $(this).closest("div.leave_msg_block").find("input.leave_msg").val();

      if( comment_text.trim() == "" ){
        $(this).closest("div.leave_msg_block").find("input.leave_msg").css("border", "1px solid red");
        return;
      }else{
        $(this).closest("div.leave_msg_block").find("input.leave_msg").css("border", "1px solid #ccc");
      }

      if( user.login_status ){
        post_comment.comment.user_id = $("li[data-user-id]").data("user-id");
      }else{
        var comment_email = $(this).closest("div.leave_msg_block").find("input.leave_email").val();
        if( comment_email.trim() == "" ){
          $(this).closest("div.leave_msg_block").find("input.leave_email").css("border", "1px solid red");
          return;
        }else{
          $(this).closest("div.leave_msg_block").find("input.leave_email").css("border", "1px solid #ccc");
          post_comment.comment.email = comment_email;
        }
      }

      post_comment.comment.text = comment_text;

      if( $(this).closest(".parent_comment").attr("data-first-message") == "true" ){ // 新增最上層留言

        var that = $(this);

        // 已登入、未登入：新增留言
        $.ajax({
          url: '/comments.json', // photo_id
          type: 'POST',
          data: post_comment,
          dataType: 'json',
          success: function(data){
            $(that).closest(".parent_comment").attr("data-first-message", false);

            $(that).closest(".parent_comment").find("div.all_comments_msg").removeClass("hidden");
            $(that).closest(".parent_comment").find("span.original_text").html(data.text);
            $(that).closest(".parent_comment").find("div.leave_msg_block").addClass("other_comments");
            $(that).closest(".parent_comment").find("span.remove_comment").addClass("hidden");
            $(that).closest(".parent_comment").find("input.original_text_edit").attr("value", data.text);

            $(that).closest(".parent_comment").attr("data-comment-id", data.id);
            $(that).closest(".parent_comment").attr("data-comment-user-id", data.user.id);

          }
        });


      }else{ // 新增子留言

        post_comment.comment.comment_id = $(this).closest(".parent_comment").attr("data-comment-id");
        post_comment.comment.photo_id = photo_id;

        $(this).closest(".parent_comment").find("ul.other_user_comments_list").removeClass("hidden");
        var that = $(this);


        $.ajax({
          url: '/comments.json',
          type: 'POST',
          data: post_comment,
          dataType: 'json',
          success: function(data){
            var source   = $("#handlebar_comment_children_create").html();
            var template = Handlebars.compile(source);

            if(data.user == null){
              var context = {
                comment_id: data.id,
                user_name: data.email,
                user_text: data.text,
                login_status: user.login_status
              };
            }else{
              var context = {
                user_id: data.user.id,
                comment_id: data.id,
                user_name: data.user.username,
                user_text: data.text,
                login_status: user.login_status
              };
            }


            var html = template(context);

            $(that).closest(".parent_comment").find("ul.other_user_comments_list").append(html);
          }
        });

      }

      // 欄位清空
      if( $(this).closest("div.leave_msg_block").find("input.leave_email").length > 0 ){
        $(this).closest("div.leave_msg_block").find("input.leave_email").val("");
      }
      $(this).closest("div.leave_msg_block").find("input.leave_msg").val("");

    });

    // 移除此留言串
    $(document).on("click", "span.remove_comment", function(){

      if( $(this).closest(".parent_comment").attr("data-comment-id") != "" ){
        var comment_id = $(this).closest(".parent_comment").attr("data-comment-id");
        var that = $(this);

        $.ajax({
          url: '/comments/' + comment_id + '.json',
          type: 'DELETE',
          dataType: 'json',
          success: function(data){
          },
          statusCode: {
            200: function(){
              $(that).closest(".parent_comment").remove();
            }
          }
        });
      }else{
        $(this).closest(".parent_comment").remove();
      }
    });

    // 最一開始的留言點擊時
    $(document).on("click", "span.original_text", function(){
      var li_original_text = $(this).closest("li.original_text");
      if( $(li_original_text).attr("data-status") == "close" ){
        $(li_original_text).attr("data-status", "open");
        $(li_original_text).find("span.original_text").css({
          "text-overflow": "inherit",
          "overflow": "visible",
          "white-space": "normal"
        });
      }else{
        $(li_original_text).attr("data-status", "close");
        $(li_original_text).find("span.original_text").css({
          "text-overflow": "ellipsis",
          "overflow": "hidden",
          "white-space": "nowrap"
        });
      }

      $(li_original_text).find("span.hint_arrow").toggleClass("hidden");
      if( user.id == $(li_original_text).closest(".parent_comment").data("comment-user-id") ){
        $(li_original_text).closest(".parent_comment").find("span.remove_comment").toggleClass("hidden");
        $(li_original_text).closest(".parent_comment").find("span.drag_comment").toggleClass("hidden");
        $(li_original_text).closest(".parent_comment").find("div.original_text_edit_block").toggleClass("hidden");
      }
      $(".parent_comment").removeClass("z_index_plus");
      $(li_original_text).closest(".parent_comment").addClass("z_index_plus");
      $(li_original_text).closest(".parent_comment").find("div.leave_msg_block").slideToggle();
      $(li_original_text).closest(".parent_comment").find("ul.other_user_comments_list").slideToggle();
    });

    // 拖曳留言
    var $dragging = null;
    $(document).on("mousedown", "div.parent_comment span.drag_comment", function (e) {
      e.preventDefault();
      e.stopPropagation();
      //$dragging = $(e.target);
      $dragging = $(this).closest("div.parent_comment");
    });

    $(comment_zone).closest("article.c_ziltag_sticker_article div.ziltag_wrapper").on("mousemove", function(e) {
      e.preventDefault();
      e.stopPropagation();
      if ($dragging) {
        $dragging.offset({
          top: e.pageY,
          left: e.pageX
        });
      }
    });

    $(comment_zone).closest("article.c_ziltag_sticker_article").on("mouseup", function (e) {
      e.preventDefault();
      e.stopPropagation();

      if ($dragging) {
        var comment_zone_img = $("[data-comments]").find("img")[0];
        var ratio = {};
        ratio.x = $(comment_zone_img)[0].clientWidth / $(comment_zone_img)[0].naturalWidth;
        ratio.y = $(comment_zone_img)[0].clientHeight / $(comment_zone_img)[0].naturalHeight;

        var posX = $($dragging).offset().left - $(this).offset().left,
            posY = $($dragging).offset().top - $(this).offset().top;

        var put_comment = {
          "comment": {
            "x": posX / ratio.x,
            "y": posY / ratio.y
          }
        };

        $($dragging).attr("data-original-x", post_comment.comment.x);
        $($dragging).attr("data-original-y", post_comment.comment.y);

        // 移動樂貼，傳送座標及id至後端
        $.ajax({
          url: '/comments/' + $($dragging).attr("data-comment-id") + '.json',
          type: 'PUT',
          data: put_comment,
          dataType: 'json',
          success: function(data){
          }
        });

        $dragging = null;
      }

    });

    allJs.handlebar_register_ifCond();

    // 編輯最上層留言
    $(document).on("click", "a.original_text_action_edit", function(e){
      e.preventDefault();
      e.stopPropagation();
      $(this).toggleClass("hidden");
      var parent_comment = $(this).closest("li.original_text");
      $(parent_comment).off("click");
      $(parent_comment).find("span.original_text, input.original_text_edit").toggleClass("hidden");
      $(parent_comment).find("input.original_text_edit").focus();
    });
    $(document).on("keyup", "input.original_text_edit", function(e){
      e.stopPropagation();
      if (e.keyCode == 13) {
        $(this).blur();
      }
    });
    $(document).on("blur", "input.original_text_edit", function(e){
      e.stopPropagation();
      var original_text = $(this).val();
      if( original_text.trim() == "" ){
        $(this).css("border", "1px solid red");
        return;
      }

      var original_text_element = $(this).closest("li.original_text");
      $(original_text_element).find("span.original_text, input.original_text_edit, a.original_text_action_edit").toggleClass("hidden");
      $(original_text_element).find("span.original_text").html( original_text.trim() );

      var put_comment = {
        "comment": {
          "text": original_text.trim()
        }
      };

      $.ajax({
        url: '/comments/' + $(this).closest("div.parent_comment").attr("data-comment-id") + '.json',
        type: 'PUT',
        data: put_comment,
        dataType: 'json',
        success: function(data){
        }
      });

    });

    // 編輯子留言
    $(document).on("click", "a.edit_children_comment", function(e){
      e.preventDefault();
      var children_comment = $(this).closest("li[data-comment-id]");
      $(children_comment).find("span.user_text, input.edit_this_children_comment").toggleClass("hidden");
      $(children_comment).find("input.edit_this_children_comment").focus();
    });
    $(document).on("keyup", "input.edit_this_children_comment", function(e){
      if (e.keyCode == 13) {
        $(this).blur();
      }
    });
    $(document).on("blur", "input.edit_this_children_comment", function(){
      var children_comment = $(this).closest("li[data-comment-id]");
      $(children_comment).find("span.user_text, input.edit_this_children_comment").toggleClass("hidden");
      $(children_comment).find("span.user_text").html( $(this).val() );

      var put_comment = {
        "comment": {
          "text": $(this).val()
        }
      };

      $.ajax({
        url: '/comments/' + $(children_comment).attr("data-comment-id") + '.json',
        type: 'PUT',
        data: put_comment,
        dataType: 'json',
        success: function(data){
        }
      });
    });

    // 刪除子留言
    $(document).on("click", "a.delete_children_comment", function(e){
      e.preventDefault();

      var comment_id = $(this).closest("li[data-comment-id]").attr("data-comment-id")
      var that = $(this);
      $.ajax({
        url: '/comments/' + comment_id + '.json',
        type: 'DELETE',
        dataType: 'json',
        success: function(data){
        },
        statusCode: {
          200: function(){
            $(that).closest("li[data-comment-id]").slideUp("slow", function(){
              $(this).remove();
            });
          }
        }
      });
    });

    // 取得舊留言
    $("article.post_ziltag_article a.old_comment, article.post_ziltag_article a.new_comment").on("click", function(e){
      e.preventDefault();

      var page = parseInt($(this).attr("data-page"));
      if( page > 0 ){
        get_all_comments(page, "");
      }

    });

  }
};

$(window).on('load page:load', function(){
  comment_init();
});

$(window).resize(function(){
    if( $("[data-comments]").length > 0 ){

      var comment_zone_img = $("[data-comments]").find("img")[0];
      var ratio = {};
      ratio.x = $(comment_zone_img)[0].clientWidth / $(comment_zone_img)[0].naturalWidth;
      ratio.y = $(comment_zone_img)[0].clientHeight / $(comment_zone_img)[0].naturalHeight;

      // 重新計算各留言的位置
      $("div.parent_comment").each(function(){
        $(this).css({
          "left": $(this).attr("data-original-x") * ratio.x,
          "top": $(this).attr("data-original-y") * ratio.y
        });
      });

    }
});