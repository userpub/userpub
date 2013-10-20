app = angular.module('userpub')

app.directive 'scrollOnAdd', ($timeout)->
  (scope, element, attrs)->
    scope.$watch attrs.scrollOnAdd, ->
      $timeout ->
        if element.children().height() - element.scrollTop() - element.height() < (element.children('li:last-child').height() + 100)
          angular.element(element).scrollTop(99999999)
    , true