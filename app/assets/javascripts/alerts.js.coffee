$ ->
  if $('.alert').text().length > 0
    $('.alert').effect('shake').delay(2000).hide('slow')

  if $('.notice').text().length > 0
    $('.notice').effect('bounce', { times: 4 }, 'slow').delay(2000).hide('slow')
