import 'package:flutter/material.dart';
import 'package:weather/controllers/weather_controller.dart';
import 'package:weather/services/weather_service.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  final WeatherController weatherController =
      Get.put(WeatherController(WeatherService()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather Forecast',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () async {
              final city = await _showSearchDialog();
              if (city != null && city.isNotEmpty) {
                weatherController.fetchCurrentWeather(city);
                weatherController.fetchAirQuality(city);
              }
            },
          ),
          const SizedBox(width: 20),
        ],
        backgroundColor: Colors.blueAccent.withOpacity(0.5),
      ),
      body: Obx(() {
        if (weatherController.isWeatherLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (weatherController.errorMessage1.value.isNotEmpty) {
          return Center(
            child: Text(
              weatherController.errorMessage1.value,
              style: const TextStyle(color: Colors.red, fontSize: 18),
            ),
          );
        } else {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Upper section for temperature
              _weatherInfoSection(
                title: 'Temperature',
                value: '${weatherController.weather.value.temperature}°C',
                gradientColors: [Colors.indigo, Colors.blueAccent],
              ),
              const SizedBox(height: 20),
              // Row for additional weather info cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _weatherInfoCard(
                    title: 'Humidity',
                    value: '${weatherController.weather.value.humidity}%',
                  ),
                  _weatherInfoCard(
                    title: 'Wind Speed',
                    value: '${weatherController.weather.value.windSpeed} m/s',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Card for Condition
              _weatherInfoCard(
                title: 'Condition',
                value: weatherController.weather.value.condition,
              ),
              const SizedBox(height: 20),
              // Card for Air Quality
              _weatherInfoCard(
                title: 'Air Quality (CO)',
                value: '${weatherController.airQuality.value.co} µg/m³',
              ),
              const SizedBox(height: 20),
              _weatherInfoCard(
                title: 'Air Quality (NO2)',
                value: '${weatherController.airQuality.value.no2} µg/m³',
              ),
              const SizedBox(height: 20),
              _weatherInfoCard(
                title: 'Air Quality (O3)',
                value: '${weatherController.airQuality.value.o3} µg/m³',
              ),
              const SizedBox(height: 20),
              _weatherInfoCard(
                title: 'Air Quality (SO2)',
                value: '${weatherController.airQuality.value.so2} µg/m³',
              ),
            ],
          );
        }
      }),
    );
  }

  Future<String?> _showSearchDialog() async {
    String city = '';
    return await Get.dialog<String>(
      AlertDialog(
        title: const Text('Enter City',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: TextField(
          onChanged: (value) {
            city = value;
          },
          decoration: const InputDecoration(hintText: 'Enter city name'),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: const Text('Search', style: TextStyle(color: Colors.blue)),
            onPressed: () {
              if (city.isNotEmpty) {
                Get.back(result: city);
              } else {
                Get.snackbar('Error', 'City name cannot be empty',
                    backgroundColor: Colors.red.withOpacity(0.5),
                    colorText: Colors.white);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _weatherInfoSection({
    required String title,
    required String value,
    required List<Color> gradientColors,
  }) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 40, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _weatherInfoCard({required String title, required String value}) {
    return Card(
      color: Colors.lightBlueAccent.withOpacity(0.5),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
