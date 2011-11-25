$ ->
  options =
    scrolling: false
    # transitionIn: 'none'
    # transitionOut: 'none'
    openEffect: 'elastic'
    openEasing: 'easeOutBack'
    closeEffect: 'elastic'
    closeEasing: 'easeInBack'
    padding: 10
    autoScale: false
    width: 640
    height: 350
  iframe = '<iframe src="http://player.vimeo.com/video/29954976?byline=0&amp;portrait=0" width="415" height="233" frameborder="0"></iframe>'
  # $('#video_image').fancybox options
  $('#video_image').click ->
    $.fancybox iframe, options
    return false