$(document).on 'turbolinks:load', ->
  $('.new-category-btn, .new-vendor-btn').on 'click', ->
    $(@).prev().toggle().val('')
    $(@).next().toggle('slow')
    $(@).toggle()

  $('.cancel').on 'click', ->
    $(@).parent().prev().prev().toggle('slow')
    $(@).parent().prev().toggle('slow')
    $(@).parent().find('input').val('')
    $(@).parent().find('textarea').val('')
    $(@).parent().find('select').val('')
    $(@).parent().toggle('slow')
