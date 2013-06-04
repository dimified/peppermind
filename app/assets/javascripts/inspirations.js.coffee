$('#char-count').text($('#inspiration_description').attr('maxlength'))
$('#inspiration_description').keyup( ()->
  maxLength = $('#inspiration_description').attr('maxlength')
  left = maxLength - $(this).val().length
  $('#char-count').text(left)
)

