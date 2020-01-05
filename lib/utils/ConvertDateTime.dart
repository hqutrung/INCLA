String ConvertDateTime(DateTime time) {
  return time.hour.toString() +
      ':' +
      time.minute.toString() +
      ' ' +
      time.day.toString() +
      '/' +
      time.month.toString() +
      '/' +
      time.year.toString();
}

String ConvertDateTimeToBirthday(DateTime time) {
  return time.day.toString() +
      '/' +
      time.month.toString() +
      '/' +
      time.year.toString();
}
