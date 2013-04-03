jQuery(document).ready ->
  # change .no-js to .js if javascript is enabled
  $document = $('html')
  $document.removeClass 'no-js'
  $document.addClass 'js'

  # off canvas main menu
  recalculateHeight = ->
    $main = $('section[role="main"]')
    $height = window.innerHeight - 44

    if $main.height() < $height
      $main.height($height)

  recalculateHeight()

  jQuery(window).resize ->
    recalculateHeight()

  $('.menu-button').click (e) ->
    e.preventDefault()
    $('body').toggleClass 'active-sidebar'
    $('.menu-button').toggleClass 'active-button'

  # use timeago plugin in time tags with .timeago class
  jQuery('time.timeago').timeago()

  # replaces rails confirmation dialog with noty-styled confirmation bar
  active = false
  clicked = false

  $.rails.allowAction = (link) ->
    if active
      return false

    return true unless link.attr('data-confirm')
    $.rails.showConfirmDialog(link)
    false

  $.rails.confirmed = (link) ->
    link.removeAttr('data-confirm')
    link.trigger('click.rails')

  $.rails.showConfirmDialog = (link) ->
    message = link.attr 'data-confirm'
    okButton =
      type: 'btn'
      text: I18n.authentication.notification.button_okay
      click: (noty) ->
        $.rails.confirmed(link)
        $('.off-canvas-navigation').find('.user-item').click()
        noty.close()
    cancelButton =
      type: 'btn btn-danger'
      text: I18n.authentication.notification.button_cancel
      click: (noty) ->
        $('.off-canvas-navigation').find('.user-item').click()
        noty.close()
    noty
      text: message
      buttons: [okButton, cancelButton]
      callback:
        onShow: ->
          active = true
        onClose: ->
          active = false

  $('.off-canvas-navigation').find('.user-item').click ->
    $notificationbar = $('#noty_top_layout_container')
    $content = $('#main-content, #menu')

    if !clicked
      clicked = true
      $notificationbar.slideDown 500
      $content.animate
        marginTop: '+=72'
      , 500
    else
      clicked = false
      $notificationbar.slideUp 500
      $content.animate
        marginTop: '-=72'
      , 500
