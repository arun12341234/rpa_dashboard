class Dashing.ChangePassword extends Dashing.Widget

  ready: ->
    $.ajax
      url: '/get_current_user'
      type: 'POST'
      dataType: 'json'
      success: (response) ->
        console.log("Current User ID: #{response.user_id}")
        if response.user_id
          console.log("Current User ID: #{response.user_id}")
        else
          console.log("No current user logged in.")
          window.location.href = '/login'
        
      error: (xhr, status, error) ->
        console.log("Error fetching current user:", error)
    # This is fired when the widget is done being rendered
    $('#change-password-form').on 'submit', (event) =>
      event.preventDefault()
      form = $(event.target)
      newPassword = $('#new_password').val()
      confirmPassword = $('#confirm_password').val()

      if newPassword != confirmPassword
        console.log("Error fetching current user:")
        # $('#change-password-message').text('New password and confirm password do not match').css('color', 'red')
        $('#change-password-message').text("New password and confirm password do not match").css({
          'background-color': 'red',
          'display': 'block' 
        });
        setTimeout ->
          $('#change-password-message').text('').css({
            'display': 'none' 
          })  # Hide the message after 5 seconds
        , 5000  # 5000 milliseconds = 5 seconds
        return

      $.ajax
        url: '/change_password'
        type: 'POST'
        data: form.serialize()
        success: (response) ->
          # $('#change-password-message').text('Password changed successfully').css('color', 'green')
          console.log('Password changed successfully')
          $('#change-password-message').text('Password changed successfully').css({
            'background-color': 'green',
            'display': 'block' 
          });
          console.log('Colors updated successfully')
          setTimeout ->
            $('#change-password-message').text('').css({
              'display': 'none' 
            })  # Hide the message after 5 seconds
          , 5000  # 5000 milliseconds = 5 seconds
        error: (xhr, status, error) ->
          console.log(JSON.parse(xhr.responseText).error)
          $('#change-password-message').text(JSON.parse(xhr.responseText).error).css({
            'background-color': 'red',
            'display': 'block' 
          });
          console.log(JSON.parse(xhr.responseText).error)
          setTimeout ->
            $('#change-password-message').text('').css({
              'display': 'none' 
            })  # Hide the message after 5 seconds
          , 5000  # 5000 milliseconds = 5 seconds

  onData: (data) ->
    console.log('New data received:', data)
    # Handle incoming data if needed