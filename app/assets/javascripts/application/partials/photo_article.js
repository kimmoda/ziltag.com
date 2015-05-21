$(document).on('ready page:load', function(){
  
  if(document.body.dataset.controller == 'photos' && document.body.dataset.action == 'index'){
    $("article[data-photo-article]").find("button[data-switch-msg-list]").each(function(){
      $(this).on("click", function(){
        $(this).closest("div").find("ul[data-msg-list] > li[data-not-first-item]").slideToggle();
        $(this).closest("div").find("ul[data-msg-list] > li[data-first-item]").toggleClass("add_bottom_line");
        $(this).find("i.fa").toggleClass("hidden");
      });
    });
  }
  
  
});