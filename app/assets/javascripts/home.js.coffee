$('#social-login').toggle('fast')
$('#toggle-social').click ->
  $('#social-login').toggle('blind', ()->
    if $('#toggle-social > i').hasClass('icon-chevron-down')
      $('#toggle-social > i').attr('class', 'icon-chevron-up')
    else if $('#toggle-social > i').hasClass('icon-chevron-up')
      $('#toggle-social > i').attr('class', 'icon-chevron-down')
  )
