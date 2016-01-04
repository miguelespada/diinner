$(document).ready(function(){
  showAlerts();
});

var showAlerts = function(){
  var notice = $(".notice").text();
  var alert = $(".alert").text();

    $.jGrowl("prueba");

  if (!isBlank(notice)){
    $.jGrowl(notice);
  }
  if (!isBlank(alert)){
    $.jGrowl(alert);
  }
};

var isBlank = function(str) {
  return (!str || /^\s*$/.test(str));
};