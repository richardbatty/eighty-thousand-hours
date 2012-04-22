$(document).ready( function() {
  $('.comment-form').submit(function() {
    $('input[type=submit]', this).attr('disabled', 'disabled');
    //$('input[type=submit]', this).val('Posting...');
  });

  $('a.reply').bind('click', function(event) {
    var replytext = $(this).siblings('.replytext').html();
    $('#comment-body').focus();
    $('#comment-body').val(replytext + "\n\n----\n\n")
  });
});
