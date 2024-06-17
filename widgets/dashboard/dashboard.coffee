class Dashing.Dashboard extends Dashing.Widget

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

    $('#logout-button').on 'click', (event) =>
      @logoutUser()

  logoutUser: ->
    $.ajax
      type: 'POST'
      url: '/logout'
      success: (response) =>
        if response.success
          alert "Logged out successfully."
          window.location.reload()  # Reload the page after logout
        else
          alert "Failed to logout."
      error: (xhr, status, error) =>
        console.error "Error while logging out:", error

  onData: (data) ->
    # Handle incoming data
    # You can access the html node of this widget with `@node`
    # Example: $(@node).fadeOut().fadeIn() will make the node flash each time data comes in.