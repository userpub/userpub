angular.module('userpub').directive 'sticky', ->
  (scope, element, attrs)->
    $(element).sticky(activeClass: 'stuck')