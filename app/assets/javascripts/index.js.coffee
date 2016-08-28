$(document).on 'turbolinks:load', ->
  $('.created_at').datepicker({
    dateFormat: 'yy-mm-dd',
    showButtonPanel: true
  })
