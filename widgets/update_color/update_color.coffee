class Dashing.UpdateColor extends Dashing.Widget

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

    $('#updatecolor-form').on 'submit', (event) ->
      event.preventDefault()
      console.log($(this).serialize(),'Colors updated successfully')
      $.ajax
        url: '/update_color'
        type: 'POST'
        data: $(this).serialize()
        success: (response) ->
          $('#update-color-message').text('Colors updated successfully').css('color', 'green')
          console.log('Colors updated successfully')
          # window.location.href = '/dashboard'  # Redirect to the dashboard or another appropriate page after processing
        error: (xhr, status, error) ->
          console.error("Error updating colors:", error)

  onData: (data) ->
    console.log(data);

    

    # Handle incoming data
    # You can access the html node of this widget with `@node`
    # Example: $(@node).fadeOut().fadeIn() will make the node flash each time data comes in.