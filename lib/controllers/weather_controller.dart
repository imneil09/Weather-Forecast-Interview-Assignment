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

  var forecast = Forecast(dateTime: [], condition: ['', '']).obs;

  var isWeatherLoading = false.obs;
  var isForecastLoading = false.obs;
  var errorMessage1 = ''.obs;
  var errorMessage2 = ''.obs;
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
      forecast(Forecast.fromJson(forecastJson));
      _saveLastCity(city);
    } catch (e) {
      errorMessage2('Failed to load forecast data');
    } finally {
      isForecastLoading(false);
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
    }
  }
}
