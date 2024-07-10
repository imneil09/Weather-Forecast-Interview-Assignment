class Weather {
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String condition;

  Weather({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.condition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['main']['temp'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      condition: json['weather'][0]['description'],
    );
  }
}
