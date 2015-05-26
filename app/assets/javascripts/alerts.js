$(document).ready(function(){
  showAlerts();
});

var showAlerts = function(){
  var notice = $(".notice").text();
  var alert = $(".alert").text();
  if (!isBlank(notice)){
    $.jGrowl(notice, { life: 50000 });
  }
  if (!isBlank(alert)){
    $.jGrowl(alert, { life: 50000 });
  }
};

var isBlank = function(str) {
  return (!str || /^\s*$/.test(str));
};