$ ->
  $.ajax
    dataType: 'json'
    url: $('#expenses-chart').data('chart-url')
    success: (result) =>
      income = result['income']
      expenses = result['expenses']
      profit = result['profit']
      months = result['months']
      profitability = result['profitability']
      net_worth = result['net_worth']

      c3.generate(
        bindto: '#expenses-chart'
        data:
          columns:[
            income
            expenses
            profit
          ]
          type: 'bar'
          labels:
            type: 'category'
        axis:
          x:
            type: 'category'
            categories: months
      )

      c3.generate(
        bindto: '#profitability-chart'
        data:
          columns:[
            ['profitability'].concat(profitability)
          ]
          type: 'line'
          labels:
            type: 'category'
        axis:
          x:
            type: 'category'
            categories: months
      )

      c3.generate(
        bindto: '#net-worth-chart'
        data:
          columns:[
            ['net_worth'].concat(net_worth)
          ]
          type: 'line'
          labels:
            type: 'category'
        axis:
          x:
            type: 'category'
            categories: months
      )
