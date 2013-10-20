app = angular.module('userpub')

app.controller 'ChatCtrl', ['$scope','angularFire','$timeout', ($scope, angularFire, $timeout)->
  $scope.messages = []
  ref = $scope.firebase.child("chat")
  
  angularFire ref.limit(25), $scope, "messages"
  
  $scope.$watch 'messages', ->
    $timeout -> $(window).scrollTop(999999999) if $scope.bottomProximity < 200
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
    
    $scope.draft.text = null
]