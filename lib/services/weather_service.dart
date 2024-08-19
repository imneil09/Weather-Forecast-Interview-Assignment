import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '418869ef940aa2fe741eecd47c001efd';

  final String currentWeatherUrl =
      'http://api.openweathermap.org/data/2.5/weather';
  final String hourlyForecastUrl =
      'https://pro.openweathermap.org/data/2.5/forecast/hourly';
  final String geoCodingUrl = 'http://api.openweathermap.org/geo/1.0/direct';
  final String airQualityUrl =
      'http://api.openweathermap.org/data/2.5/air_pollution';

  Future<Map<String, dynamic>> fetchCurrentWeather(String city) async {
    final response = await http.get(
        Uri.parse('$currentWeatherUrl?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Map<String, dynamic>> fetchHourlyForecast(String city) async {
    final response = await http.get(
        Uri.parse('$hourlyForecastUrl?q=$city&appid=$apiKey'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load hourly forecast data');
    }
  }

  Future<Map<String, dynamic>> fetchAirQuality(String city) async {
    double? latitude, longitude;

    final resp = await http.get(
        Uri.parse('$geoCodingUrl?q=$city&limit=1&appid=$apiKey'));
    if (resp.statusCode == 200) {
      List<dynamic> data = jsonDecode(resp.body);
      if (data.isNotEmpty) {
        latitude = data[0]['lat'];
        longitude = data[0]['lon'];
      } else {
        throw Exception('Geocoding API returned no results');
      }
    } else {
      throw Exception('Failed to fetch geocoding data');
    }

    final response = await http.get(
        Uri.parse('$airQualityUrl?lat=$latitude&lon=$longitude&appid=$apiKey'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load air quality data');
    }
  }
}
