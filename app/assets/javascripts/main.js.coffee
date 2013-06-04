jQuery(document).ready ->
  # off canvas main menu
  recalculateHeight = ->
    $main = $('section[role="main"]')
    $height = window.innerHeight - 42

    if $main.height() < $height
      $main.height($height)

  recalculateHeight()

  jQuery(window).resize ->
    recalculateHeight()

  $('.menu-button').on 'click', (e) ->
    e.preventDefault()
    $('body').toggleClass 'active-sidebar'
    $('.menu-button').toggleClass 'active-button'

  # back button
  $('.back-item').find('a').on 'click', (e) ->
    e.preventDefault()
    history.back()

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
      text: I18n.notification.button_okay
      click: (noty) ->
        $('.off-canvas-navigation').find('.confirmation').click()
        noty.close()
        active = false
        $.rails.confirmed(link)
    cancelButton =
      type: 'btn btn-danger'
      text: I18n.notification.button_cancel
      click: (noty) ->
        $('.off-canvas-navigation').find('.confirmation').click()
        noty.close()
        active = false
    noty
      text: message
      buttons: [okButton, cancelButton]
      callback:
        onShow: ->
          active = true

  $('.confirmation').on 'click', () ->
    $notificationbar = $('#noty_top_layout_container')

    if !clicked
      clicked = true
      $notificationbar.animate
        top: '42'
      , 500
    else
      clicked = false
      $notificationbar.animate
        top: '-85'
      , 500
