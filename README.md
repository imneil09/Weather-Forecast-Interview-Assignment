# Weather Forecast Application Interview Assesment

A simple weather forecast application for Android and iOS devices built using Flutter. This application retrieves weather data from a public API and displays it to the user. Users can search for weather forecasts based on location (city) and view relevant weather information such as temperature, humidity, wind speed, and weather condition.

## Features

- Search weather forecasts by city name.
- Display current weather information: temperature, humidity, wind speed, and condition.
- Clean and intuitive user interface.
- Graceful handling of errors and invalid inputs.

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) installed on your system.
- An API key from OpenWeatherMap or another supported weather API.

### Installation

1. **Clone the repository:**
   ```sh
   git clone https://github.com/imneil09/Weather-Forecast-Interview-Assignment.git

2. **Navigate to the project directory:**
   ```sh
   cd weather

3. **Install the dependencies:**
   ```sh
   flutter pub get

4. **Running the application:**
   ```sh
   flutter run

### Project Structure
    
    weather/
    ├── android
    ├── build
    ├── ios
    ├── lib
    │   ├── controllers
    │   │   └── weather_controller.dart
    │   ├── models
    │   │   └── weather_model.dart
    │   ├── services
    │   │   └── weather_service.dart
    │   ├── views
    │   │   └── home_view.dart
    │   └── main.dart
    ├── test
    ├── .gitignore
    ├── pubspec.lock
    └── pubspec.yaml
