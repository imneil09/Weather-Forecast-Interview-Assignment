import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/services/weather_service.dart';
import '../model/weather_model.dart';

class WeatherController extends GetxController {
  var weather = Weather(
    temperature: 0,
    humidity: 0,
    windSpeed: 0,
    condition: '',
  ).obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  final String lastCityKey = 'Delhi';
  final WeatherService weatherService;

  WeatherController(this.weatherService);

  @override
  void onInit() {
    super.onInit();
    _loadLastCity();
  }

  Future<void> fetchWeather(String city) async {
    try {
      isLoading(true);
      errorMessage('');
      final weatherJson = await weatherService.fetchWeather(city);
      weather(Weather.fromJson(weatherJson));
      _saveLastCity(city);
    } catch (e) {
      errorMessage('Failed to load weather data');
    } finally {
      isLoading(false);
    }
  }

  Future<void> _saveLastCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(lastCityKey, city);
  }

  Future<void> _loadLastCity() async {
    final prefs = await SharedPreferences.getInstance();
    final lastCity = prefs.getString(lastCityKey);
    if (lastCity != null && lastCity.isNotEmpty) {
      fetchWeather(lastCity);
    }
  }




}
