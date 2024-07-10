import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '418869ef940aa2fe741eecd47c001efd';
  final String baseUrl = 'http://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final response = await http.get(Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
