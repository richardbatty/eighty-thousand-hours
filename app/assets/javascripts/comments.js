$(document).ready( function() {
  $('.comment-form').submit(function() {
    $('input[type=submit]', this).attr('disabled', 'disabled');
    //$('input[type=submit]', this).val('Posting...');
  });
});
