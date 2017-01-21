$(document).on 'turbolinks:load', ->
  table = $('.datatable').dataTable
    aaSorting: []
    drawCallback: ->
      trs = $('.datatable > tbody > tr')
      $(trs).unbind('click')
      $(trs).click (event) ->
        unless $(event.toElement).data('clear-pending-expense') || $(event.toElement).data('archive-resource')
          tr = @
          id = $(tr).data('id')
          name = $(tr).data('model-name')
          controller = $(tr).data('form-controller')
          $.ajax
            url: "/forms/?model_id=#{id}&model_name=#{name}&form_controller=#{controller}"
            method: 'POST'
            success: (response) ->
              $('#empty-modal-content').empty().append(response)
              $('select').selectize()
              $('#empty-modal-trigger').click()
