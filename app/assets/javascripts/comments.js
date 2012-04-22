$(document).ready( function() {
  $('.comment-form').submit(function() {
    $('input[type=submit]', this).attr('disabled', 'disabled');
    //$('input[type=submit]', this).val('Posting...');
  });

  $('a.reply').bind('click', function(event) {
    //var commentid = $(this).siblings('.commentid').html();
    //$('#comment-parent').val(commentid);
    $('#comment-body').focus();
  });
});
