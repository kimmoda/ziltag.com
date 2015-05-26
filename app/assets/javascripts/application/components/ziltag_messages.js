var ZiltagMessages = {
  
  // 發佈
  data_send_message: function(){
    $("[data-ziltag-messages]").each(function(){
      $(this).find("[data-send-message]").on("click", function(){
        //$(this).closest("[data-send-msg-block]").find("textarea[data-send-msg-block]").val();
        var message = $(this).closest("[data-send-msg-block]").find("textarea[data-user-input-message]").val();
        
        var source   = $("#all_msg_list_item").html();
        var template = Handlebars.compile(source);
        var context = {message: message};
        var html    = template(context);
        
        $("ul[data-all-msg-list]").append(html);
        
      });
    });
  }
};