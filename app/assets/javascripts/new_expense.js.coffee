$ ->
  $('.new-category-btn, .new-vendor-btn').on 'click', ->
    $(@).prev().toggle()
    $(@).next().toggle()
    $(@).toggle()

  $('.cancel').on 'click', ->
    $(@).parent().prev().prev().toggle()
    $(@).parent().prev().toggle()
    $(@).parent().find('input').val('')
    $(@).parent().find('textarea').val('')
    $(@).parent().find('select').val('')
    $(@).parent().toggle()
