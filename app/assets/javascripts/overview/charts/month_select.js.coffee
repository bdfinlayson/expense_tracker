$ ->
  $('#year-select').on 'change', ->
    window.location = "overviews?year=#{@.selectedOptions[0].value}"
