dinnerApp.service('UserManager',['$resource', function($resource) {
  this.getUser = function() {
    return $resource('http://diinner.herokuapp.com/ionic/user.json').get()
  };

  this.updateUser = function(user) {
    return $resource('http://diinner.herokuapp.com/ionic/user').save({user: user});
  };

}]);


dinnerApp.service('CityManager',['$resource', function($resource) {
  this.getCities = function() {
    return $resource('http://diinner.herokuapp.com/ionic/cities.json').get();
  };
}]);
