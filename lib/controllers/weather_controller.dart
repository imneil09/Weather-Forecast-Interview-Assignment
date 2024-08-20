import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/weather_model.dart';
import '../services/weather_service.dart';

class WeatherController extends GetxController {
  var weather = Weather(
    temperature: 0,
    humidity: 0,
    windSpeed: 0,
    condition: '',
  ).obs;

  var airQuality = Air(co: 0.0, no2: 0.0, o3: 0.0, so2: 0.0).obs;

  var isWeatherLoading = false.obs;
  var isAirQualityLoading = false.obs;
  var errorMessage1 = ''.obs;
  var errorMessage3 = ''.obs;
  final String lastCityKey = 'lastCity'; // Use a more descriptive key name
  final WeatherService weatherService;

  WeatherController(this.weatherService);

  @override
  void onInit() {
    super.onInit();
    _loadLastCity();
  }

  Future<void> fetchCurrentWeather(String city) async {
    try {
      isWeatherLoading(true);
      errorMessage1('');
      final weatherJson = await weatherService.fetchCurrentWeather(city);
      weather(Weather.fromJson(weatherJson));
      _saveLastCity(city);
    } catch (e) {
      errorMessage1('Failed to load weather data: $e');
    } finally {
      isWeatherLoading(false);
    }
  }

  Future<void> fetchAirQuality(String city) async {
    try {
      isAirQualityLoading(true);
      errorMessage3('');
      final airJson = await weatherService.fetchAirQuality(city);
      airQuality(Air.fromJson(airJson));
    } catch (e) {
      errorMessage3('Failed to load air data: $e');
    } finally {
      isAirQualityLoading(false);
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
      fetchCurrentWeather(lastCity);
      fetchAirQuality(lastCity);
    }
  }
}
