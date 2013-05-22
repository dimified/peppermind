jQuery ->
  # endless scrolling
  isScrolledIntoView = (elem) ->
    docViewTop = $(window).scrollTop()
    docViewBottom = docViewTop + $(window).height()
    elemTop = $(elem).offset().top
    (elemTop >= docViewTop) && (elemTop <= docViewBottom)

  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next a').attr('href')
      if url && isScrolledIntoView('.pagination')
        $('.pagination').text(I18n.endless_scrolling.loading_label)
        $.getScript(url)

    $(window).scroll()

  # datepicker
  $('.datepicker').datepicker
    dateFormat: 'dd.mm.yy'
    defaultDate: +7
    minDate: 1
