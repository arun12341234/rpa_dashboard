class Dashing.RpaWig extends Dashing.Widget
  @accessor 'current', Dashing.AnimatedValue
  # @accessor 'comp_record', Dashing.AnimatedValue
  # @accessor 'difference', ->
  #   console.log("Calculating difference...")
  #   totalProcessed = @get('total_records_processed')
  #   totalFailed = @get('total_failed_records')
  #   if totalProcessed and totalFailed
  #     diff = Math.abs(Math.round((totalFailed - totalProcessed) / totalProcessed * 100))
  #     "#{diff}%"
  #   else
  #     "100%"


  onData: (data) ->
    # console.log('New data received:', data)
    if data.status
      # clear existing "status-*" classes
      $(@get('node')).attr 'class', (i,c) ->
        c.replace /\bstatus-\S+/g, ''
      # add new class
      $(@get('node')).addClass "status-#{data.status}"

    @updateColor(data)
    

    
  redirect: (data) ->
    if data? and data.innerText.trim() isnt ""
        link_data = data.innerText.split("\n")[1]
        console.log(link_data)
        location.href = 'execution_data?bot_name=' + encodeURIComponent(link_data)
        # location.href = 'execution_data'
    else
        console.log("not exist")
    
  updateColor: (data) ->
    console.log('New data received:',data, data.color_rules)
    selector = "div[data-id='" + data.dataid + "']"
    rpaElements = $(selector)
    rpaElements.each (index, element) ->
      console.log(
        element
      )

      current = data.current
      if current < 25
        $(element).css "background-color", data.color_rules.tail_bg_color_0_25
      else if current < 50
        $(element).css "background-color", data.color_rules.tail_bg_color_25_50
      else if current < 75
        $(element).css "background-color", data.color_rules.tail_bg_color_50_75
      else
        $(element).css "background-color", data.color_rules.tail_bg_color_75_100
        # $(element).css "color", data.color_rules.tail_bg_color_75_100
    selector1 = "div[data-id='" + data.dataid + "'] h1"
    h1Elements = $(selector1)
    h1Elements.each (index, element) ->

      console.log(
        element
      )
      current = data.current
      if current < 25
        $(element).css "color", data.color_rules.tail_fg_color_0_25
      else if current < 50
        $(element).css "color", data.color_rules.tail_fg_color_25_50
      else if current < 75
        $(element).css "color", data.color_rules.tail_fg_color_50_75
      else
        $(element).css "color", data.color_rules.tail_fg_color_75_100
    selector2 = "div[data-id='" + data.dataid + "'] h4"
    h4Elements = $(selector2)
    h4Elements.each (index, element) ->

      console.log(
        element
      )
      current = data.current
      if current < 25
        $(element).css "color", data.color_rules.tail_fg_color_0_25
      else if current < 50
        $(element).css "color", data.color_rules.tail_fg_color_25_50
      else if current < 75
        $(element).css "color", data.color_rules.tail_fg_color_50_75
      else
        $(element).css "color", data.color_rules.tail_fg_color_75_100
    selector3 = "div[data-id='" + data.dataid + "'] h4 span"
    h4sElements = $(selector3)
    h4sElements.each (index, element) ->

      console.log(
        element
      )
      current = data.current
      if current < 25
        $(element).css "color", data.color_rules.tail_fg_color_0_25
      else if current < 50
        $(element).css "color", data.color_rules.tail_fg_color_25_50
      else if current < 75
        $(element).css "color", data.color_rules.tail_fg_color_50_75
      else
        $(element).css "color", data.color_rules.tail_fg_color_75_100

    selector4 = "div[data-id='" + data.dataid + "'] span"
    sElements = $(selector4)
    sElements.each (index, element) ->

      console.log(
        element
      )
      current = data.current
      if current < 25
        $(element).css "color", data.color_rules.tail_fg_color_0_25
      else if current < 50
        $(element).css "color", data.color_rules.tail_fg_color_25_50
      else if current < 75
        $(element).css "color", data.color_rules.tail_fg_color_50_75
      else
        $(element).css "color", data.color_rules.tail_fg_color_75_100
    