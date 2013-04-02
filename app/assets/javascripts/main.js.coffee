jQuery(document).ready ->
  # change .no-js to .js if javascript is enabled
  $document = $('html')
  $document.removeClass 'no-js'
  $document.addClass 'js'

  # off canvas main menu
  $main = $('section[role="main"]')
  $height = window.innerHeight - 40

  if ($main.height() < $height)
    $main.height($height)

  $('.menu-button').click (e) ->
    e.preventDefault()
    $('body').toggleClass 'active-sidebar'
    $('.menu-button').toggleClass 'active-button'

  # use timeago plugin in time tags with .timeago class
  jQuery('time.timeago').timeago()

  # replaces rails confirmation dialog with noty-styled confirmation dialog
  dialog = false

  $.rails.allowAction = (link) ->
    if (dialog)
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
      text: 'Okay'
      click: (noty) -> $.rails.confirmed(link); noty.close()
    cancelButton =
      type: 'btn btn-danger'
      text: 'Cancel'
      click: (noty) -> noty.close()
    noty
      text: message
      buttons: [okButton, cancelButton]
      callback:
        onShow: ->
          dialog = true
        afterClose: ->
          dialog = false
