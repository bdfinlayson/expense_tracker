$(document).on 'turbolinks:load', ->
  $('.datatable').DataTable()

  $('.datatable > tbody > tr').click ->
    tr = @
    id = $(tr).data('id')
    name = $(tr).data('model-name')
    controller = $(tr).data('form-controller')
    $.ajax
      url: "/forms/?model_id=#{id}&model_name=#{name}&form_controller=#{controller}"
      method: 'POST'
      success: (response) ->
        $('#empty-modal-content').empty().append(response)
        $('#empty-modal-trigger').click()
