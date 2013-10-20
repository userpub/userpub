app = angular.module('userpub')

app.directive 'distanceFromBottom', ($timeout)->
  (scope, element, attrs)->
    $(window).scroll ->
      $timeout ->
        distance = $(document).height() - $(window).scrollTop() - $(window).height()
        scope[attrs.distanceFromBottom] = distance