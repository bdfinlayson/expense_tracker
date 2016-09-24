$ ->
  $.ajax
    dataType: 'json'
    url: '/overviews/data'
    success: (result) =>
      income = result['income']
      expenses = result['expenses']
      profit = result['profit']
      months = result['months']
      profitability = result['profitability']

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

