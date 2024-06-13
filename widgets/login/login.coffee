class Dashing.Login extends Dashing.Widget

  # ready: ->
    # This is fired when the widget is done being rendered
  ready: ->
    $('#login-form').on 'submit', (event) ->
      event.preventDefault()
      username = $('#username').val()
      password = $('#password').val()
      console.log(username)

      # Clear any previous error messages
      $('#error-message').text('')

      # Perform AJAX request for authentication
      $.ajax
        url: '/login'
        type: 'POST'
        contentType: 'application/json'
        data: JSON.stringify({ username: username, password: password })
        success: (response) ->
          if response.success
            window.location.href = '/dashboard'
          else
            $('#error-message').text(response.error)

  onData: (data) ->
    # Handle incoming data
    # You can access the html node of this widget with `@node`
    # Example: $(@node).fadeOut().fadeIn() will make the node flash each time data comes in.