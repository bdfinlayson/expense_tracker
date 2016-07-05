$(document).on 'turbolinks:load', ->
  $('.sliding-panel-button,.sliding-panel-fade-screen,.sliding-panel-close').on 'click touchstart', (e) ->
    $('.sliding-panel-content,.sliding-panel-fade-screen').toggleClass 'is-visible'
    e.preventDefault()
