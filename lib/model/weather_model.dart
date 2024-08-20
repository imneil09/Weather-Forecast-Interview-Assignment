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

class HourlyWeather {
  final DateTime dateTime;
  final double temperature;
  final String weatherDescription;

  HourlyWeather({
    required this.dateTime,
    required this.temperature,
    required this.weatherDescription,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: json['temp'].toDouble(),
      weatherDescription: json['weather'] != null && json['weather'].isNotEmpty
          ? json['weather'][0]['description']
          : 'No description',
    );
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
      co: json['list'] != null && json['list'].isNotEmpty
          ? json['list'][0]['components']['co'].toDouble()
          : 0.0,
      no2: json['list'] != null && json['list'].isNotEmpty
          ? json['list'][0]['components']['no2'].toDouble()
          : 0.0,
      o3: json['list'] != null && json['list'].isNotEmpty
          ? json['list'][0]['components']['o3'].toDouble()
          : 0.0,
      so2: json['list'] != null && json['list'].isNotEmpty
          ? json['list'][0]['components']['so2'].toDouble()
          : 0.0,
    );
  }
}
