// 新增樂貼

// 準備傳送資料的 Object
var obj_post_data = {};

var newZiltag = {
  
  posX:0,
  posY:0,
  
  postImageUrl:"http://notes.carlos-studio.com/ajax_upload_image/upload.php",
  
  dropFile:{},
  
  appendImage: function(theElement, url){
    $(theElement).prepend("<article class='img_article'><img src='" + url + "' class='user_image img-responsive'></article>");
  },
  
  
  // 圖片預覽
  readURLFromNewZiltagModal: function(selectedFile, dropElement, dropElementHint, type) {
    if (selectedFile.files && selectedFile.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        
        $(dropElement).find("img").remove();
        newZiltag.appendImage(dropElement, e.target.result);
        $(dropElementHint).addClass('hidden');
        
        $("span.not_image, span.is_image").addClass("hidden");
        $("span.is_image").removeClass("hidden");
        $("button.image_confirm").attr("data-choose-type", type);
        $("input.fetch_images").val('');
        
      }
      reader.readAsDataURL(selectedFile.files[0]);
    }
  },
  
  handleFileUpload: function(){
    //var drop_file = newZiltag.dropFile;
    
    var fd = new FormData();
    fd.append('selected_file', newZiltag.dropFile);
 
    $.ajax({
      url: newZiltag.postImageUrl,
      type: "POST",
      data: fd,
      contentType: false,
      cache: false,
      processData:false,
      xhr: function() {
        var myXhr = $.ajaxSettings.xhr();
        if(myXhr.upload){
          myXhr.upload.addEventListener('progress', function(e){
            if(e.lengthComputable){
              var progress_percent = parseInt((e.loaded / e.total) * 100);
              //console.log(progress_percent + " %");
              $("#progress_bar").css("display", "block");
              $('#progress_bar #dynamic_progress').css("width", progress_percent + "%");
              $('#progress_bar #dynamic_progress').html( progress_percent + " %" );
            }
          }, false);
        }
        return myXhr;
      },
      success: function(data)   // A function to be called if request succeeds
      {
        $("div.init_zone, div.edit_zone").toggleClass("hidden");
        $("img.uploaded_image").attr("src", $("img.user_image").attr("src"));
        console.log(data);
      }
    });
    
  },
  
  
  // 直接從檔案視窗拖曳至指定區域
  dropFile: function(dropElement, dropElementHint){
    var document_body = $('body')[0];
    document_body.ondragover = function () {  return false; };
    document_body.ondragend = function () {  return false; };
    document_body.ondrop = function () {  return false; };
    
    dropElement.ondragover = function () {  return false; };
    dropElement.ondragend = function () {  return false; };
    
    dropElement.ondrop = function (e) {
      e.preventDefault();
      newZiltag.readURLFromNewZiltagModal(e.dataTransfer, dropElement, dropElementHint, "drop_file");
      
      // 準備傳圖的檔案
      var drop_file = e.dataTransfer.files[0];
      newZiltag.dropFile = drop_file;
      
      return false;
    };
  },
  
  setPos: function(theElement, e){
    var img_uploaded_image = $(theElement).find("img.uploaded_image")[0];
    var image_ratio = img_uploaded_image.clientWidth / img_uploaded_image.naturalWidth;
    
    var posX = $(theElement).offset().left,
        posY = $(theElement).offset().top;
    
    newZiltag.posX = parseInt(e.pageX - posX);
    newZiltag.posY = parseInt(e.pageY - posY);
    
    obj_post_data.x = parseInt(newZiltag.posX / image_ratio);
    obj_post_data.y = parseInt(newZiltag.posY / image_ratio);
  }
  
};





main(function(){
  if( $("[data-ziltag-new-modal]").length > 0 ){
    
    
    
    $("[data-ziltag-new-modal]").on("click", function(e){
      e.preventDefault();
    });
    
    // search_filter_text
    $("button.btn_search_filter").on('click', function(e){
      e.preventDefault();
      var search_text = $(this).closest("div.new_and_filter").find("input.search_filter").val();
      $(this).closest("div.left_side").find("ul.list_ul > li").each(function(){
        $(this).addClass("hidden");
        $( "h3.post_title:contains('" + search_text + "')" ).closest("li").removeClass("hidden");
      });
    });
    
    
    // 拖曳檔案
    newZiltag.dropFile($('#drop_file')[0], $('div.drop_file_hint')[0]);
    
    // 選擇檔案視窗
    $('#drop_file').on('click', function(){
      $("#selected_file").click();
    });
    $("#selected_file").change(function(){
      newZiltag.readURLFromNewZiltagModal(this, $('#drop_file')[0], $('div.drop_file_hint')[0], "select_file");
    });
    
    // 將文字框全選
    $("input.fetch_images").on('click', function(){
      $(this).select();
    });
    // 所貼的連結是否為圖片
    $("input.fetch_images").on("keyup", function(){
      var that = $(this);
      $("<img>", {
        src: $(this).val(),
        error: function() {
          $("span.not_image, span.is_image").addClass("hidden");
          $("span.not_image").removeClass("hidden");
          
          $('#drop_file').find("img").remove();
          $('div.drop_file_hint').removeClass('hidden');
        },
        load: function(e) {
          $("span.not_image, span.is_image").addClass("hidden");
          $("span.is_image").removeClass("hidden");
          
          $('#drop_file').find("img").remove();
          newZiltag.appendImage($('#drop_file')[0], $(that).val());
          $('div.drop_file_hint').addClass('hidden');
        }
      });
      
      
    });
    
    // 圖片選擇確定
    $("button.image_confirm").on("click", function(){
      $(this).attr("disabled", "disabled");
      
      if( $(this).attr("data-choose-type") == "select_file" ){
        $("#uploadimage").submit();
      }else{
        newZiltag.handleFileUpload();
      }
      
      
    });
    // 上傳圖片至server
    $("#uploadimage").on('submit',function(e) {
      e.preventDefault();
      
      $.ajax({
        url: newZiltag.postImageUrl,
        type: "POST",
        data: new FormData(this),
        contentType: false,
        cache: false,
        processData:false,
        xhr: function() {
          var myXhr = $.ajaxSettings.xhr();
          if(myXhr.upload){
            myXhr.upload.addEventListener('progress',progressHandlingFunction, false);
          }
          return myXhr;
        },
        success: function(data)   // A function to be called if request succeeds
        {
          $("div.init_zone, div.edit_zone").toggleClass("hidden");
          $("img.uploaded_image").attr("src", $("img.user_image").attr("src"));
          console.log(data);
        }
      });
    });
    // progress
    function progressHandlingFunction(e){
      if(e.lengthComputable){
        var progress_percent = parseInt((e.loaded / e.total) * 100);
        //console.log(progress_percent + " %");
        $("#progress_bar").css("display", "block");
        $('#progress_bar #dynamic_progress').css("width", progress_percent + "%");
        $('#progress_bar #dynamic_progress').html( progress_percent + " %" );
      }
    }
    
    // 圖片點擊取得座標
    $(document).on("click", "article.img_article", function(e){
      newZiltag.setPos($(this), e);
      
      $("#edit_ziltag_modal input.ziltag_id").val('');
      $("#edit_ziltag_modal input.ziltag_title").val('');
      $('.ziltag_content').redactor('code.set', '');
      $('.ziltag_tags').importTags('');
      $("#edit_ziltag_modal").modal("show");
    });
    
    $(".ziltag_content").redactor({
      buttons: ['image', 'link'],
      imageUpload: '/url',
      plugins: ['video']
    });
    
    $(".ziltag_tags").tagsInput({
      'defaultText':'主題標籤',
      'width': '100%',
      'height': '50px'
    });
    
    // 資料儲存
    $("button.ziltag_save").on("click", function(e){
      e.preventDefault();
      var form_string = $(this).closest("form").serialize();
      form_string_array = form_string.split("&");
      $.each(form_string_array, function(index, value){
        var data = value.split("=");
        obj_post_data[data[0]] = data[1];
      });
      
      // 標題
      var this_title = $(this).closest("form").find("input[name=ziltag_title]").val();
      // 內文
      var this_content = $(this).closest("form").find('textarea[name=ziltag_msg]').redactor('code.get');
      // 標籤
      var this_tags = $(this).closest("form").find('input.ziltag_tags').val();
      
      if( obj_post_data.ziltag_id != "" ){
        var post_list_item = $("#ziltag_new_modal ul.post_list li[data-id=" + obj_post_data.ziltag_id + "]");
        $(post_list_item).find("h3.title").html(this_title);
        $(post_list_item).find("div.post_contents").html(this_content);
        $(post_list_item).find("div.all_tags").html(this_tags);
      }else{
        var d = new Date();
        var return_id = d.getTime();
        
        // 貼上樂貼
        var source   = $("#handlebar_ziltag_sticker").html();
        var template = Handlebars.compile(source);
        var context = {x: newZiltag.posX, y: newZiltag.posY, id: return_id};
        var html    = template(context);
        $("#ziltag_new_modal div.ziltag_wrapper").append(html);
        
        
        // 放入文章
        var source   = $("#handlebar_ziltag_msg").html();
        var template = Handlebars.compile(source);
        var context = {ziltag_title: this_title, ziltag_msg: this_content, id: return_id, ziltag_tags: this_tags};
        var html    = template(context);
        $("#ziltag_new_modal ul.post_list li").addClass("hidden");
        $("#ziltag_new_modal ul.post_list").prepend(html);
      }
      
      $(this).closest(".modal").modal("hide");
      
      // 傳送圖片內容至後端
      $.ajax({
    		url: '代入後端 url',
    		type: 'POST',
    		data: JSON.stringify(obj_post_data),
    		dataType: 'json',
    		success: function(data){
    		  console.log(data);
    		}
    	});
      
    });
    
    // 點擊樂貼切換底部的文章列表
    $(document).on("click", "#ziltag_new_modal a.ziltag", function(e){
      e.preventDefault();
      e.stopPropagation();
      
      var that = $(this);
      $("#ziltag_new_modal ul.post_list li").each(function(){
        if( $(this).data("id") == $(that).data("id") ){
          $(this).removeClass("hidden");
        }else{
          $(this).addClass("hidden");
        }
      });
    });
    
    // 拖曳樂貼
    $(document).on("mousedown", "#ziltag_new_modal a.ziltag", function(e){
      e.preventDefault();
      e.stopPropagation();
      var that = $(this);
      var article_img_article = $(this).closest("article.img_article");
      
      var $dragging = null;
      $("div.ziltag_wrapper").on("mousemove", function(e) {
        e.preventDefault();
        e.stopPropagation();
        if ($dragging) {
          $dragging.offset({
            top: e.pageY,
            left: e.pageX
          });
        }
      });
      $("div.ziltag_wrapper").on("mousedown", $(this), function (e) {
        e.preventDefault();
        e.stopPropagation();
        $dragging = $(e.target);
      });
      $("div.ziltag_wrapper").on("mouseup", function (e) {
        e.preventDefault();
        e.stopPropagation();
        $dragging = null;
        newZiltag.setPos($(article_img_article), e);
        
        obj_post_data.ziltag_id = $(that).data("id");
        delete obj_post_data.ziltag_title;
        delete obj_post_data.ziltag_msg;
        delete obj_post_data.ziltag_tags;
        
        
        // 移動樂貼，傳送座標及id至後端
        $.ajax({
      		url: '代入後端更新樂貼位置的 url',
      		type: 'POST',
      		data: JSON.stringify(obj_post_data),
      		dataType: 'json',
      		success: function(data){
      		  console.log(data);
      		}
      	});
        
      });
    });
    
    // 輯編樂貼
    $(document).on("click", "#ziltag_new_modal a.edit_ziltag_sticker", function(e){
      e.preventDefault();
      e.stopPropagation();
      
      $("#edit_ziltag_modal input.ziltag_id").val($(this).data("id"));
      $("#edit_ziltag_modal input.ziltag_title").val($(this).closest("li").find("h3.title").text());
      $('.ziltag_content').redactor('code.set', $(this).closest("li").find("div.post_contents").html());
      $('.ziltag_tags').importTags($(this).closest("li").find("div.all_tags").html());
      $("#edit_ziltag_modal").modal("show");
    });
    
    // 刪除樂貼
    $(document).on("click", "#ziltag_new_modal a.delete_ziltag_sticker", function(e){
      e.preventDefault();
      e.stopPropagation();
      
      $("#ziltag_new_modal a.ziltag[data-id=" + $(this).data("id") + "]").remove();
      $(this).closest("li").remove();
      
      // 傳送圖片內容至後端
      $.ajax({
    		url: '代入後端要刪除樂貼的 url',
    		type: 'POST',
    		data: "id=" + $(this).data("id"),
    		dataType: 'json',
    		success: function(data){
    		  console.log(data);
    		}
    	});
    });
    
    
    
  }
  
  
  
});


$(window).resize(function(){
  
});