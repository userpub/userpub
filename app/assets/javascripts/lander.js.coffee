#= require jquery
#= require angular/angular
#= require angular-animate/angular-animate
#= require angular-bootstrap/ui-bootstrap

app = angular.module('userpub.lander', ['ngAnimate', 'ui.bootstrap'])

app.controller 'PersonaCtrl', ['$scope', '$element', '$timeout', ($scope, $element, $timeout)->
  $scope.login = ->
    analytics.track 'Persona Login', page: window.location.pathname
    navigator.id.get (assertion)->
      $element.find("input[name=assertion]").val(assertion)
      $element.submit()
    false
]

$ ->
  $("a[track-event]").each ->
    $this = $(@)
    event = $this.attr('track-event')
    properties = JSON.parse($this.attr('track-data')) if $(@).attr('track-data')
    analytics.trackLink @, event, properties
  
  analytics.trackForm $("form[action='/demo']"), "Launched Demo"