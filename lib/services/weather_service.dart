import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '418869ef940aa2fe741eecd47c001efd';

  final String currentWeatherUrl = 'http://api.openweathermap.org/data/2.5/weather';
  final String hourlyForecastUrl = 'http://api.openweathermap.org/data/2.5/forecast';
  final String sunUrl = 'https://api.openweathermap.org/energy/1.0/solar/data';
  final String airQualityUrl = 'http://api.openweathermap.org/data/2.5/air_pollution';

  Future<Map<String, dynamic>> fetchCurrentWeather(String city) async {
    final response = await http.get(Uri.parse('$currentWeatherUrl?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Map<String, dynamic>> fetchHourlyForecast(String city) async {
    final response = await http.get(Uri.parse('$hourlyForecastUrl?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load hourly forecast data');
    }
  }

  Future<Map<String, dynamic>> fetchSolarData(String city) async {
    final response = await http.get(Uri.parse('$sunUrl?q=$city&appid=$apiKey'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load solar data');
    }
  }

  Future<Map<String, dynamic>> fetchAirQuality(String city) async {
    final response = await http.get(Uri.parse('$airQualityUrl?q=$city&appid=$apiKey'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load air quality data');
    }
  }
}
