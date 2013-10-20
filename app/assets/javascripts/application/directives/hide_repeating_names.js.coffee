app = angular.module('userpub')

app.directive 'hideRepeatingNames', ($timeout)->
  (scope, element, attrs)->
    scope.$watch 'messages', ->
      $timeout ->
        name = null
        oldName = null
        element.find(".username").each ->
          name = $(@).text()
          if name == oldName
            $(@).addClass("ng-hide")
          oldName = name
    , true  