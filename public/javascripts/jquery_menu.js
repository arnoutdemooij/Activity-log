$(function() {

  $("ul#main-menu li").hover(function() {
    $(this).addClass("sub_hover")
           .find("ul.sub").slideDown(100).show();

    $(this).hover(function() {

    }, function() {  
      $(this).find("ul.sub").slideUp(100);
    });

  }, function() {
    $(this).removeClass("sub_hover");
  });

});