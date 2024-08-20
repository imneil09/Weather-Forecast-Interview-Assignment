import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '418869ef940aa2fe741eecd47c001efd';

  final String currentWeatherUrl =
      'http://api.openweathermap.org/data/2.5/weather';
  final String geoCodingUrl = 'http://api.openweathermap.org/geo/1.0/direct';
  final String airQualityUrl =
      'http://api.openweathermap.org/data/2.5/air_pollution';

  Future<Map<String, dynamic>> fetchCurrentWeather(String city) async {
    final response = await http.get(Uri.parse(
        '$currentWeatherUrl?q=${Uri.encodeComponent(city)}&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to load weather data for $city. Status code: ${response.statusCode}');
    }
  }

  Future<List<double>> geoCoding(String city) async {
    final response = await http.get(Uri.parse(
        '$geoCodingUrl?q=${Uri.encodeComponent(city)}&limit=1&appid=$apiKey'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        double latitude = data[0]['lat'];
        double longitude = data[0]['lon'];
        return [latitude, longitude];
      } else {
        throw Exception('Geocoding API returned no results for $city');
      }
    } else {
      throw Exception(
          'Failed to fetch geocoding data for $city. Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> fetchAirQuality(String city) async {
    List<double> coordinates = await geoCoding(city);

    final response = await http.get(Uri.parse(
        '$airQualityUrl?lat=${coordinates[0]}&lon=${coordinates[1]}&appid=$apiKey'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to load air quality data for $city. Status code: ${response.statusCode}');
    }
  }
}
