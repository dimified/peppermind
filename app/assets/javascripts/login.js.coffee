$('#toggle-social').click ->
  $('#social-login').toggle('blind', ()->
    if $('#toggle-social > i').hasClass('icon-chevron-down')
      $('#toggle-social > i').attr('class', 'icon-chevron-up')
      $('#toggle-social').css({
        'border-bottom-left-radius' : '0px',
        'border-bottom-right-radius' : '0px'
      })
    else if $('#toggle-social > i').hasClass('icon-chevron-up')
      $('#toggle-social > i').attr('class', 'icon-chevron-down')
      $('#toggle-social').css({
        'border-bottom-left-radius' : '2px',
        'border-bottom-right-radius' : '2px'
      })
  )

