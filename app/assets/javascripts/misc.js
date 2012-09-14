$(document).ready(function () {  
  // enable button loading state on all form buttons
  $('form').find('.btn').button()
  $('form').find('.btn').click(function() {
    $(this).button('loading');
  });
  $('.toggleLink').click(function(){
    $(this).hide();
    $(this).siblings('.toggle_div').show();
  });
});
