$(document).on 'turbolinks:load', ->
  table = $('.datatable').dataTable
    aaSorting: []
    drawCallback: ->
      $('.datatable > tbody > tr').click (event) ->
        unless $(event.toElement).data('clear-pending-expense')
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
