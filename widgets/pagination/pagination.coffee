class Dashing.Pagination extends Dashing.Widget

  ready: ->
    @getData()

  getData: ->
    @get 'pagination', (data) =>
      @onData(data)

  onData: (data) ->
    @renderPagination(data)

  renderPagination: (data) ->
    console.log(data)
    arKeys = Object.keys(data).filter((key) ->
      key != "id" and key != "updatedAt"
    ).map((key) ->
      { value: data[key], text: key }
    )
    console.log(arKeys)
    # arKeys = Object.keys(data).filter((key) -> key.startsWith('AR'))
    totalItems = arKeys.length
    itemsPerPage = 15
    totalPages = Math.ceil(totalItems / itemsPerPage)
    maxButtons = Math.min(totalPages, 9)
    console.log(maxButtons)

    paginationContainer = $('#pagination-1-container')
    paginationContainer.empty()
    if maxButtons
      for i in [1..maxButtons]
        console.log(i)
        li = $("<li class='pagination-li'>").text(i)
        li.on 'click', ((pageNum) -> () ->
          window.location.href = "rpa0#{pageNum}"
        )(i)
        paginationContainer.append(li)

# Assuming you have additional setup code for Dashing.Widget and @get method handling elsewhere
