$(document).ready(function () {  
  // smooth scrolling on all local links
  $.localScroll();

  // enable button loading state on all form buttons
  $('form').find('.btn').button()
  $('form').find('.btn').click(function() {
    $(this).button('loading');
  });
});
