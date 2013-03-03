$('#mozilla-persona').click (event) ->
  event.preventDefault()
  navigator.id.request siteName: 'Peppermind'
  navigator.id.watch
    loggedInUser: 'undefined'
    onlogin: (assertion) ->
      $.ajax
        type: 'POST'
        url: '/auth/persona/callback'
        data:
          assertion: assertion
        success: (res, status, xhr) ->
          window.location.reload()
        error: (xhr, status, error) ->
          console.error(error)
    onlogout: ->
