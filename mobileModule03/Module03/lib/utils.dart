String getFirstDayOfTheWeekInString() {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    DateTime realDate = date.subtract(Duration(days: date.weekday - 1));
    var dateTime = realDate.toString();
    dateTime = dateTime.substring(0, dateTime.indexOf(" "));
    return dateTime;
  }