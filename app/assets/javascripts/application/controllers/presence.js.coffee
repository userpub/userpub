app = angular.module('userpub')

app.controller 'PresenceCtrl', ['$scope', 'angularFire', ($scope, angularFire)->
  angularFire $scope.firebase.child('connections'), $scope, 'connections'
]