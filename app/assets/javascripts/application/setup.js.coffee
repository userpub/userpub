angular.module('userpub', ['ngAnimate', 'ngResource', 'firebase', 'ngRoute']).run ($rootScope, angularFireAuth)->
  $rootScope.firebase = new Firebase(state.firebase + '/')
  angularFireAuth.initialize $rootScope.firebase,
    scope: $rootScope
    name: 'user'
  angularFireAuth.login state.firebase_token