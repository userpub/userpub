app = angular.module('userpub')

app.controller 'ChatCtrl', ['$scope','angularFire','$timeout','$notification', ($scope, angularFire, $timeout, $notification)->
  $scope.messages = []
  ref = $scope.firebase.child("chat")
  
  hiddenPrefix = ->
    if 'hidden' in document
      return 'hidden'
    
    for prefix in ['webkit','moz','ms','o']
      if (prefix + 'Hidden') in document
        return prefix + 'Hidden'
    
    null
  
  ref.on 'child_added', (snapshot)->
    message = snapshot.val()
    $notification.info message.user.name, message.text if document.webkitHidden
    
  angularFire ref.limit(150), $scope, "messages"
  
  $scope.$watch 'messages', ->
    $timeout -> $(window).scrollTop(999999999) if $scope.bottomProximity < 800
  , true
  
  $scope.authorIds = []
  authorDetails = (user)->
    out = {}
    out.name = user.name
    out.id = user.id
    out.staff = user.staff
    out.admin = user.admin
    out.title = user.title if user.title?
    out
  
  $scope.messageKeypress = ($event)->
    $scope.sendMessage() if event.keyCode == 13 and !event.shiftKey
    
  $scope.sendMessage = ->
    ref.push
      user: authorDetails($scope.user.d)
      text: $scope.draft.text
    
    $(window).scrollTop(999999999)
    $scope.draft.text = ""
]