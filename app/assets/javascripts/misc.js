$(document).ready(function () {  
  // smooth scrolling on all local links
  $.localScroll();


  // default text in form inputs
  $(".defaultText").focus(function(srcc)
    {
      if ($(this).val() == $(this)[0].title)
  {
    $(this).removeClass("defaultTextActive");
    $(this).val("");
  }
    });

  $(".defaultText").blur(function()
    {
      if ($(this).val() == "")
  {
    $(this).addClass("defaultTextActive");
    $(this).val($(this)[0].title);
  }
    });

  $(".defaultText").blur();     
});
