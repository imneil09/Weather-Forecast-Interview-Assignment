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
      temperature: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      condition: json['weather'][0]['description'],
    );
  }
}

class Forecast {
  final DateTime dateTime;
  final String condition;

  Forecast({
    required this.dateTime,
    required this.condition,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      dateTime: DateTime.parse(json['dt_txt']),
      condition: json['weather'][0]['description'],
    );
  }

  static List<Forecast> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Forecast.fromJson(json)).toList();
  }
}


class Air {
  final double co;
  final double no2;
  final double o3;
  final double so2;

  Air({
    required this.co,
    required this.no2,
    required this.o3,
    required this.so2,
  });

  factory Air.fromJson(Map<String, dynamic> json) {
    return Air(
      co: json['list'][0]['components']['co'].toDouble(),
      no2: json['list'][0]['components']['no2'].toDouble(),
      o3: json['list'][0]['components']['o3'].toDouble(),
      so2: json['list'][0]['components']['so2'].toDouble(),
    );
  }
}
