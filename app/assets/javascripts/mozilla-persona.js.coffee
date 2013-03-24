$('#mozilla-persona').click (event) ->
  event.preventDefault()
  navigator.id.watch
    loggedInUser: null
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
  navigator.id.request siteName: 'Peppermind'
