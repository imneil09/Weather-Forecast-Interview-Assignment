import 'package:flutter/material.dart';
import 'package:weather/controllers/weather_controller.dart';
import 'package:weather/services/weather_service.dart';
import 'package:get/get.dart';

// ignore: use_key_in_widget_constructors
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
              if (city != null) {
                weatherController.fetchCurrentWeather(city);
                weatherController.fetchHourlyForecast(city);
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
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [Colors.indigo, Colors.blueAccent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Temperature',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${weatherController.weather.value.temperature}°C',
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Row for additional weather info cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Card for Humidity
                  _weatherInfoCard(
                    title: 'Humidity',
                    value: '${weatherController.weather.value.humidity}%',
                  ),
                  // Card for Wind Speed
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
              const SizedBox(
                height: 20,
              ),
              // Row for Forecast
              Container(
                margin: const EdgeInsets.all(10.0),
                height: 200.0, // Height of the cards
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        width: 150.0, // Width of the cards
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                '${weatherController.forecast.value.dateTime[0]}',
                                style: const TextStyle(fontSize: 20.0),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                weatherController.forecast.value.condition[0],
                                style: const TextStyle(fontSize: 20.0),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  // Function to show search dialog and return city name
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
              Get.back(result: city);
            },
          ),
        ],
      ),
    );
  }

  // Widget for displaying weather information cards
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
