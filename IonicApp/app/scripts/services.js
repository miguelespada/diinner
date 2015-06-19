dinnerApp.service('UserManager',['$resource', function($resource) {
  this.getUser = function() {
    return $resource('http://localhost:3000/ionic/user.json').get()
  };

  this.updateUser = function(user) {
    return $resource('http://localhost:3000/ionic/user').save({user: user});
  };

}]);


dinnerApp.service('CityManager',['$resource', function($resource) {
  this.getCities = function() {
    return $resource('http://localhost:3000/ionic/cities.json').get();
  };
}]);
