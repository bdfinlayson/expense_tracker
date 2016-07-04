$(document).on 'turbolinks:load', ->
  $('.update-vendor, .update-expense, .update-category').on 'click', ->
    $(@).next().children().click()

  $('.edit-vendor, .edit-expense, .edit-category').on 'click', ->
    $(@).toggle()
    $(@).next().toggle()
    $(@).next().next().toggle()
    $(@).parent().parent().find('input').toggle()
    $(@).parent().parent().find('select').toggle()
    $(@).parent().parent().find('.row-item').toggle()

  $('.cancel-edit').on 'click', ->
    $(@).toggle()
    $(@).prev().toggle()
    $(@).next().toggle()
    $(@).parent().parent().find('input').toggle()
    $(@).parent().parent().find('select').toggle()
    $(@).parent().parent().find('.row-item').toggle()
