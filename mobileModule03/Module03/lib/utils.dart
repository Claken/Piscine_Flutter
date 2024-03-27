String getFirstDayOfTheWeekInString() {
  DateTime now = DateTime.now();
  DateTime date = DateTime(now.year, now.month, now.day);
  DateTime realDate = date.subtract(Duration(days: date.weekday - 1));
  var dateTime = realDate.toString();
  dateTime = dateTime.substring(0, dateTime.indexOf(" "));
  return dateTime;
}

final Map<String, String> weatherMap = {
  '0': 'Clear sky',
  '1': 'Mainly clear',
  '2': 'Partly cloudy',
  '3': 'Overcast',
  '45': 'Fog and depositing rime fog',
  '48': 'Fog and depositing rime fog',
  '51': 'Drizzle: Light intensity',
  '53': 'Drizzle: Moderate intensity',
  '55': 'Drizzle: Dense intensity',
  '56': 'Freezing Drizzle: Light intensity',
  '57': 'Freezing Drizzle: Dense intensity',
  '61': 'Rain: Slight intensity',
  '63': 'Rain: Moderate intensity',
  '65': 'Rain: Heavy intensity',
  '66': 'Freezing Rain: Light intensity',
  '67': 'Freezing Rain: Heavy intensity',
  '71': 'Snow fall: Slight intensity',
  '73': 'Snow fall: Moderate intensity',
  '75': 'Snow fall: Heavy intensity',
  '77': 'Snow grains',
  '80': 'Rain showers: Slight intensity',
  '81': 'Rain showers: Moderate intensity',
  '82': 'Rain showers: Violent intensity',
  '85': 'Snow showers: Slight intensity',
  '86': 'Snow showers: Heavy intensity',
  '95': 'Thunderstorm: Slight or moderate',
  '96': 'Thunderstorm with slight hail',
  '99': 'Thunderstorm with heavy hail',
};

final Map<String, String> weatherIcons = {
  'Clear sky': '',
  'Mainly clear': '',
  'Partly cloudy': '',
  'Overcast': '',
  'Fog and depositing rime fog': '',
  'Drizzle: Light intensity': '',
  'Drizzle: Moderate intensity': '',
  'Drizzle: Dense intensity': '',
  'Freezing Drizzle: Light intensity': '',
  'Freezing Drizzle: Dense intensity': '',
  'Rain: Slight intensity': '',
  'Rain: Moderate intensity': '',
  'Rain: Heavy intensity': '',
  'Freezing Rain: Light intensity': '',
  'Freezing Rain: Heavy intensity': '',
  'Snow fall: Slight intensity': '',
  'Snow fall: Moderate intensity': '',
  'Snow fall: Heavy intensity': '',
  'Snow grains': '',
  'Rain showers: Slight intensity': '',
  'Rain showers: Moderate intensity': '',
  'Rain showers: Violent intensity': '',
  'Snow showers: Slight intensity': '',
  'Snow showers: Heavy intensity': '',
  'Thunderstorm: Slight or moderate': '',
  'Thunderstorm with slight hail': '',
  'Thunderstorm with heavy hail': '',
};

final Map<String, String> location = {
  'cityName': '',
  'region': '',
  'country': '',
  'lat': '',
  'long': ''
};
