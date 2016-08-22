$(document).on 'turbolinks:load', ->
  $('.update').on 'click', ->
    $(@).next().next().children().click()

  $('.created_at').datepicker({
    dateFormat: 'yy-mm-dd',
    showButtonPanel: true,
  })

  $('.edit').on 'click', ->
    $(@).toggle()
    $(@).next().toggle()
    $(@).next().next().toggle()
    $(@).next().next().next().toggle()
    $(@).closest('tr').find('input').toggle()
    $(@).closest('tr').find('select').toggle()
    $(@).closest('tr').find('.row-item').toggle()

  $('.cancel').on 'click', ->
    $(@).prev().toggle()
    $(@).toggle()
    $(@).next().toggle()
    $(@).next().next().toggle()
    $(@).closest('tr').find('input').toggle()
    $(@).closest('tr').find('select').toggle()
    $(@).closest('tr').find('.row-item').toggle()
