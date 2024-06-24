class Dashing.UpdateColor extends Dashing.Widget

  ready: ->
    $.ajax
      url: '/post_option'
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
      console.log($(this).serialize(),'Color Settings updated successfully')
      $.ajax
        url: '/update_color'
        type: 'POST'
        data: $(this).serialize()
        success: (response) ->
          $('#update-color-message').text('Colors changed successfully').css('color', 'green')
          console.log('Colors updated successfully')
          # window.location.href = '/dashboard'  # Redirect to the dashboard or another appropriate page after processing
        error: (xhr, status, error) ->
          console.error("Error changing colors:", error)

  onData: (data) ->
    console.log(data);

    

    # Handle incoming data
    # You can access the html node of this widget with `@node`
    # Example: $(@node).fadeOut().fadeIn() will make the node flash each time data comes in.