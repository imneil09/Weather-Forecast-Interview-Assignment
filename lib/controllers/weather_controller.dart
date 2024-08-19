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

  var forecast = <Forecast>[].obs; // Change to a list of Forecast objects

var airQuality = Air(co: 0.0, no2: 0.0, o3: 0.0, so2: 0.0).obs;

  var isWeatherLoading = false.obs;
  var isForecastLoading = false.obs;
  var isAirQualityLoading = false.obs;
  var errorMessage1 = ''.obs;
  var errorMessage2 = ''.obs;
  var errorMessage3 = ''.obs;
  final String lastCityKey = 'Delhi';
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
      errorMessage1('Failed to load weather data');
    } finally {
      isWeatherLoading(false);
    }
  }

  Future<void> fetchHourlyForecast(String city) async {
    try {
      isForecastLoading(true);
      errorMessage2('');
      final forecastJson = await weatherService.fetchHourlyForecast(city);
      // Update the forecast list
      forecast(Forecast.fromJsonList(forecastJson['list']));
    } catch (e) {
      errorMessage2('Failed to load forecast data');
    } finally {
      isForecastLoading(false);
    }
  }

  Future<void> fetchAirQuality(String city) async {
    try {
      isAirQualityLoading(true);
      errorMessage3('');
      final airJson = await weatherService.fetchAirQuality(city);
      airQuality(Air.fromJson(airJson));
    } catch (e) {
      errorMessage3('Failed to load air data');
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
      fetchHourlyForecast(lastCity);
      fetchAirQuality(lastCity);
    }
  }
}
