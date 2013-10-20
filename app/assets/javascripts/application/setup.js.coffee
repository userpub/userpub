app = angular.module('userpub', ['ngAnimate', 'firebase', 'ngRoute', 'ngSanitize', 'ui.bootstrap', 'emoji', 'notifications'])

app.run ['$rootScope', 'angularFireAuth', '$notification', ($rootScope, angularFireAuth, $notification)->
  $rootScope.firebase = new Firebase(state.firebase + '/')
  $rootScope.account = state.account
  
  $notification.enableHtml5Mode()
  
  angularFireAuth.initialize $rootScope.firebase,
    scope: $rootScope
    name: 'user'
  angularFireAuth.login state.firebase_token if state.firebase_token
  
  $rootScope.$on "angularFireAuth:login", (evt, user)->
    connections = $rootScope.firebase.child("connections")
    ref = connections.push(user.d)
    ref.onDisconnect().remove()
]
  
# app.config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider)->
#   $locationProvider.html5Mode true
#   $routeProvider
#     .when('/', templateUrl: '/partials/home.html', controller: 'HomeCtrl')
#     .when('/questions', templateUrl: '/partials/questions/index.html', controller: 'QuestionsCtrl')
#     .when('/questions/:questionId', templateUrl: '/partials/questions/show.html', controller: 'QuestionsDetailCtrl')
#     .when('/guides', templateUrl: '/partials/guides/index.html', controller: 'QuestionsCtrl')
#     .when('/guides/:guideId', templateUrl: '/partials/guides/show.html', controller: 'QuestionsDetailCtrl')
#     .when('/suggestions', templateUrl: '/partials/suggestions/index.html', controller: 'QuestionsCtrl')
#     .when('/suggestions/:suggestionId', templateUrl: '/partials/suggestions/show.html', controller: 'QuestionsDetailCtrl')
#     .otherwise(redirectTo: '/')
# ]