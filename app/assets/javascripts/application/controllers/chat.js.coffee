app = angular.module('userpub')

app.controller 'ChatCtrl', ($scope, angularFire)->
  $scope.messages = []
  ref = $scope.firebase.child("chat")
  
  angularFire ref.limit(100), $scope, "messages"
  
  $scope.authorIds = []
  authorDetails = (user)->
    out = {}
    out.name = user.name
    out.id = user.id
    out.staff = user.staff
    out.title = user.title if user.title?
    out
  
  $scope.messageKeypress = ($event)->
    $scope.sendMessage() if event.keyCode == 13 and !event.shiftKey
  
  $scope.lastMessageUserId = (index)->
    debugger
    $scope.messages[index-1]?.user?.id
  
  $scope.sendMessage = ->
    ref.push
      user: authorDetails($scope.user.d)
      text: $scope.draft.text
    
    $scope.draft.text = null