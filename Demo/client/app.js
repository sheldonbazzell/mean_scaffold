var app = angular.module('app', ['ngRoute'])
app.config(function($routeProvider) {
  $routeProvider
    .when('/', {
      templateUrl: 'assets/partials/index.html',
      controller:  'indexController'
    }) 
    .when('/new/:class', {
      templateUrl: 'assets/partials/new.html',
      controller:  'newController'
    }) 
    .when('/:class/:id', {
      templateUrl: 'assets/partials/show.html',
      controller:  'showController'
    }) 
     .otherwise('/');
 });
var app = angular.module('app', ['ngRoute'])
app.config(function($routeProvider) {
  $routeProvider
    .when('/', {
      templateUrl: 'assets/partials/index.html',
      controller:  'indexController'
    }) 
    .when('/new/:class', {
      templateUrl: 'assets/partials/new.html',
      controller:  'newController'
    }) 
    .when('/:class/:id', {
      templateUrl: 'assets/partials/show.html',
      controller:  'showController'
    }) 
     .otherwise('/');
 });
var app = angular.module('app', ['ngRoute'])
app.config(function($routeProvider) {
  $routeProvider
    .when('/', {
      templateUrl: 'assets/partials/index.html',
      controller:  'indexController'
    }) 
    .when('/new/:class', {
      templateUrl: 'assets/partials/new.html',
      controller:  'newController'
    }) 
    .when('/:class/:id', {
      templateUrl: 'assets/partials/show.html',
      controller:  'showController'
    }) 
     .otherwise('/');
 });
var app = angular.module('app', ['ngRoute'])
app.config(function($routeProvider) {
  $routeProvider
    .when('/', {
      templateUrl: 'assets/partials/index.html',
      controller:  'indexController'
    }) 
    .when('/new/:class', {
      templateUrl: 'assets/partials/new.html',
      controller:  'newController'
    }) 
    .when('/:class/:id', {
      templateUrl: 'assets/partials/show.html',
      controller:  'showController'
    }) 
     .otherwise('/');
 });
