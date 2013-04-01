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
