#= require jquery
#= require angular/angular
#= require angular-animate/angular-animate
#= require angular-bootstrap/ui-bootstrap

app = angular.module('userpub.lander', ['ngAnimate', 'ui.bootstrap'])

app.controller 'PersonaCtrl', ['$scope', '$element', '$timeout', ($scope, $element, $timeout)->
  $scope.login = ->  
    navigator.id.get (assertion)->
      $element.find("input[name=assertion]").val(assertion)
      $element.submit()
    false
]