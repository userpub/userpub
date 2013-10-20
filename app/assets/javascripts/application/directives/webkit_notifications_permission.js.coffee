angular.module('userpub').directive 'grantNotification', ['$notification', ($notification)->
  (scope, element, attrs)->
    if !window.webkitNotifications || window.webkitNotifications.checkPermission() == 0
      element.addClass 'ng-hide'
    else
      element.on 'click', -> $notification.enableHtml5Mode()
]