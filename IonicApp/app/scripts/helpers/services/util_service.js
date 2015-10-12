"use strict";

dinnerApp.service('UtilService', function(){
  function chunkInRows(arr, size) {
    var newArr = [];
    for (var i=0; i<arr.length; i+=size) {
      newArr.push(arr.slice(i, i+size));
    }
    return newArr;
  }

  function extendObject(target, source) {
    for (var i in source) {
      try {
        // Property in destination object set; update its value.
        target[i] = (source[i].constructor==Object) ? extendObject(target[i], source[i]) : source[i];
      } catch(e) {
        // Property in destination object not set; create it and set its value.
        target[i] = source[i];
      }
    }
    return target;
  }

  function dateValue(stringValue, quantity){
    var oneDay = 24 * 60 * 60 * 1000;
    switch(stringValue){
      case "today": return new Date(); break;
      case "tomorrow": return new Date(new Date().getTime() + oneDay); break;
      case "afterTomorrow": return new Date(new Date().getTime() + oneDay * (quantity ? 1 + quantity : 2)); break;
      default: return new Date();
    }
  }

  function dateToString(date){
    var dd = date.getDate();
    var mm = date.getMonth()+1; //January is 0!
    var yyyy = date.getFullYear();

    if(dd<10) {
      dd='0'+dd
    }

    if(mm<10) {
      mm='0'+mm
    }

    return dd+'/'+mm+'/'+yyyy;
  }

  function stringToDate(strDate){
    var dateParts = strDate.split("/");
    return new Date(dateParts[2], (dateParts[1] - 1), dateParts[0]);
  }

  function isDateToday(date){
    return compareDates("eq", new Date(date), new Date());
  }

  function compareDates(type, date_1, date_2){
    switch(type) {
      case "eq":
        return date_1.getYear() == date_2.getYear()
          && date_1.getMonth() == date_2.getMonth()
          && date_1.getDay() == date_2.getDay();
      case "gt":
        return date_1.getYear() > date_2.getYear()
          || (
            date_1.getYear() == date_2.getYear()
            && date_1.getMonth() > date_2.getMonth()
          )
          || (
            date_1.getYear() == date_2.getYear()
            && date_1.getMonth() == date_2.getMonth()
            && date_1.getDay() > date_2.getDay()
          );
      case "gte":
        return compareDates("gt", date_1, date_2)
          || compareDates("eq", date_1, date_2);
      default:
        return false
    }

  }

  function compareTimes(type, time_1, time_2){
    switch(type) {
      case "eq":
          return time_1.getHours() == time_2.getHours()
            && time_1.getMinutes() == time_2.getMinutes()
            && time_1.getSeconds() == time_2.getSeconds();
      case "gt":
          return time_1.getHours() > time_2.getHours()
            || (
              time_1.getHours() == time_2.getHours()
              && time_1.getMinutes() > time_2.getMinutes()
            )
            || (
              time_1.getHours() == time_2.getHours()
              && time_1.getMinutes() == time_2.getMinutes()
              && time_1.getSeconds() > time_2.getSeconds()
            );
      case "gte":
         return compareTimes("gt", time_1, time_2)
           || compareTimes("eq", time_1, time_2);
      default:
            return false
    }
  }

  function compareDatesAndTimes(type, date_1, date_2){
    switch(type){
      case "eq":
        return compareDates(type, date_1, date_2)
          && compareTimes(type, date_1, date_2);
      case "gt":
        return compareDates(type, date_1, date_2)
          || (
            compareDates("eq", date_1, date_2)
            && compareTimes(type, date_1, date_2)
          );
      case "gte":
        return compareDatesAndTimes("eq", date_1, date_2)
          || compareDatesAndTimes("gt", date_1, date_2);
      default:
        return false
    }

  }

  return {
    chunkInRows: chunkInRows,
    extendObject: extendObject,
    dateToString: dateToString,
    stringToDate: stringToDate,
    dateValue: dateValue,
    isDateToday: isDateToday,
    compareDates: compareDates,
    compareTimes: compareTimes,
    compareDatesAndTimes: compareDatesAndTimes
  }
});
