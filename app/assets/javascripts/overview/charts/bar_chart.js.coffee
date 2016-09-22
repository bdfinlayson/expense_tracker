$ ->
  $.ajax
    dataType: 'json'
    url: '/overviews/data'
    success: (result) =>
      income = result['income']
      expenses = result['expenses']
      profit = result['profit']
      c3.generate(
        bindto: '#chart'
        data:
          columns:[
            income
            expenses
            profit
          ]
          type: 'bar'
      )

