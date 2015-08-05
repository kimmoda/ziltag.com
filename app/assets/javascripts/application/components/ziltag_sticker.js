var ZiltagSticker = {
  // 置換modal的內容
  replaceModalData: function(data, thisElement){
    window.history.pushState(null, null, data.link);

    $("[data-user-username]").html(data.user.username);
    $("[data-user-avatar]").attr("src", data.user.avatar);
    $("[data-post-title]").html(data.post.title);

    $("[data-post-content]").html(data.post.content);
    $("[data-dreated-at]").html(data.created_at);

    $("[data-modal-post-ziltag-article]").find("[data-show-sticker]").attr("data-ziltag-x", data.x).attr("data-ziltag-y", data.y);

    $("[data-location-name]").html(data.location.name);
    $("[data-location-address]").html(data.location.address);
    $("[data-follow-block]").html(data.following_button);
    $("[data-precious-block]").html(data.collecting_button);
    $("[data-image_url]").attr("src", data.image_url);

    // 切換紅灰樂貼
    if( thisElement !== null ){
      thisElement.classList.add('active');
      other_a_tags = thisElement.parentNode.getElementsByTagName('a');
      for(var i = 0; i < other_a_tags.length; i++)
        if(other_a_tags[i] !== thisElement) other_a_tags[i].classList.remove('active');
    }

  },

  // modal 視窗
  appendImgOnModal: function(data){
    
    var source   = $("#handlebar_ziltag_wrapper").html();
    var template = Handlebars.compile(source);
    var context = {
      image_url: data.image_url, x: data.x, y: data.y,
      other_ziltaggings: data.other_ziltaggings,
      link: data.link
    };
    var html    = template(context);

    var ziltag_wrapper = $("[data-modal-post-ziltag-article]").find("[data-ziltag-sticker-article]");
    $(ziltag_wrapper).find(".ziltag_wrapper").remove();
    $(ziltag_wrapper).prepend(html);

    // 留言
    if( $("[data-comments]").length > 0 ){
      var component_zone_img = $("[data-comments]").find("img")[0];
      $(component_zone_img).one("load", function() {
        $("[data-comments]").children("img").attr("data-photo-id", data.post.id);
        comment_reset();
        comment_init();
      }).attr("src", data.image_url);
    }
  }
};