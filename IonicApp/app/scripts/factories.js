dinnerApp.factory('User', ['$resource', function($resource) {
  return $resource('http://localhost:3000/ionic/user.json')
}]);
