$(document).on 'turbolinks:load', ->
  $('.make-root-node').on 'click', ->
    $(@).prev().val('')
