class Dashing.TailDelete extends Dashing.Widget

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
    $('#dropdown-form').on 'submit', (e) =>
      e.preventDefault()
      selectedOption = $('#dropdown').val()
      console.log(
          selectedOption
      )
      $.ajax
        url: '/post_option'
        type: 'POST'
        contentType: 'application/json'
        data: JSON.stringify({ selectedOption: selectedOption })
        success: (response) ->
          console.log(response)
          if response.success
            $('#update-color-message').html("<p>Deleting........!</p><p>This may take 30 seconds</p>").css({
              'background-color': 'green',
              'display': 'block' 
            });
            setTimeout ->
              $('#update-color-message').fadeOut('slow'); # Hide the message after 5 seconds
            , 5000  # 5000 milliseconds = 5 seconds



          else
            $('#update-color-message').text('Operation failed').css('color', 'red')
        error: (xhr, status, error) ->
          $('#update-color-message').text("Error: #{error}").css('color', 'red')

  onData: (data) ->
    # Extract options from the data excluding non-option keys
    options = Object.keys(data).filter((key) ->
      key != "id" and key != "updatedAt"
    ).map((key) ->
      { value: data[key], text: key }
    )

    # arKeys = Object.keys(data).filter((key) -> key.startsWith('AR'))
    # totalItems = arKeys.length
    # console.log(
    #   options
    # )
    dropdown = $('#dropdown')
    dropdown.empty()
    for option in options
      # console.log(
      #     option
      # )
      dropdown.append "<option value='#{option.text}'>#{option.text}</option>"


    # Handle incoming data
    # You can access the html node of this widget with `@node`
    # Example: $(@node).fadeOut().fadeIn() will make the node flash each time data comes in.