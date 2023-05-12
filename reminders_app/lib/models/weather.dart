class WeatherData {
  final String date;
  final String condition;
  final String temperature;
  final String iconUrl;

  WeatherData({
    required this.date,
    required this.condition,
    required this.temperature,
    required this.iconUrl,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final date = json['date'];
    final condition = json['day']['condition']['text'];
    final temperature =
        '${json['day']['avgtemp_c']}°C / ${json['day']['avgtemp_f']}°F';
    final iconUrl = 'https:${json['day']['condition']['icon']}';

    return WeatherData(
      date: date,
      condition: condition,
      temperature: temperature,
      iconUrl: iconUrl,
    );
  }
}
