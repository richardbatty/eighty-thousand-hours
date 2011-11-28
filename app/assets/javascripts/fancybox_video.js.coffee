$ ->
  # fancybox-rails uses fancybox 1.3
  # tried to submit pull requests, but he has failing tests,
  # so just raised an issue for now
  options_fancybox_1_3 =
    padding : 10
    margin : 40
    opacity : false
    modal : false
    cyclic : false
    scrolling : 'no',	# 'auto', 'yes' or 'no'
    
    width : 640
    height : 360
    
    autoScale : true
    autoDimensions : true
    centerOnScroll : false
    
    hideOnOverlayClick : true
    hideOnContentClick : false
    
    overlayShow : true
    overlayOpacity : 0.8
    overlayColor : '#000'
    
    titleShow : false
    titlePosition : 'float', # 'float', 'outside', 'inside' or 'over'
    titleFormat : null
    titleFromAlt : false
    
    transitionIn : 'fade', # 'elastic', 'fade' or 'none'
    transitionOut : 'fade', # 'elastic', 'fade' or 'none'
    
    speedIn : 300
    speedOut : 300
    
    changeSpeed : 300
    changeFade : 'fast'
    
    easingIn : 'swing'
    easingOut : 'swing'
    
    showCloseButton	 : false
    showNavArrows : false
    enableEscapeButton : true
    enableKeyboardNav : true
    
    onStart: ->
    onCancel: ->
    onComplete: ->
    onCleanup: ->
    onClosed: ->
    onError: ->
    
    
  options_fancybox_2_0 =
    scrolling: 'no'
    # transitionIn: 'none'
    # transitionOut: 'none'
    closeBtn: false
    openEffect: 'elastic'
    openEasing: 'easeOutBack'
    closeEffect: 'elastic'
    closeEasing: 'easeInBack'
    padding: 10
    autoScale: false
    width: 640
    height: 360
    openSpeed: 700
    helpers:
      overlay:
        buttons: {}
        opacity: 0.3
        css:
          'background-color': '#000'

  iframe = '<iframe src="http://player.vimeo.com/video/32787159?byline=0&amp;portrait=0&amp;autoplay=1" width="640" height="360" frameborder="0"></iframe>'
  
  $('#video_image').click ->
    $.fancybox iframe, options_fancybox_1_3
    return false
