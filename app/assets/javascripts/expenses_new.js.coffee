$(document).on 'turbolinks:load', ->
  $('#expense_created_at').datepicker({ dateFormat: 'yy-mm-dd'})

  $('.new-category-btn, .new-vendor-btn').on 'click', ->
    $(@).prev().toggle().val('')
    $(@).next().toggle('slow')
    $(@).toggle()

  $('.cancel-add').on 'click', ->
    $(@).parent().prev().prev().toggle('slow')
    $(@).parent().prev().toggle('slow')
    $(@).parent().find('input').val('')
    $(@).parent().find('textarea').val('')
    $(@).parent().find('select').val('')
    $(@).parent().toggle('slow')
