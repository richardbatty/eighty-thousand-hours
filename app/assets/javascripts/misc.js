$(document).ready(function () {  
  $('.toggleLink').click(function(){
    $(this).hide();
    $(this).siblings('.toggle_div').show();
  });
});
