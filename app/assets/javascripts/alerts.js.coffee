$ ->
  if $('.alert').text().length > 0
    $('.alert').effect('shake', {times: 6}, 'slow').delay(3500).toggle('slow')

  if $('.notice').text().length > 0
    $('.notice').effect('bounce', { times: 6 }, 'slow').delay(2500).toggle('slow')
