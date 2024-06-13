class Dashing.Dashboard extends Dashing.Widget

  ready: ->
  #   @checkSession()
  #   # This is fired when the widget is done being rendered

  # checkSession: ->
  #   $.ajax
  #     url: '/logout'
  #     type: 'POST'
  #     dataType: 'json'
  #     console.log("check User is logged in")
  #     success: (response) =>
  #       console.log("User is logged in")

  onData: (data) ->
    # Handle incoming data
    # You can access the html node of this widget with `@node`
    # Example: $(@node).fadeOut().fadeIn() will make the node flash each time data comes in.