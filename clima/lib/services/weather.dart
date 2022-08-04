import 'package:clima/services/location.dart';
import 'package:clima/services/Networking.dart';

class WeatherModel {
  Future<dynamic>getcityweather(String cityName) async {
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=00d7cef67e0677079cee456d30a7d402&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData =await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getcurrentlocation();
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=00d7cef67e0677079cee456d30a7d402&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s time for a bottle of cold fanta';
    } else if (temp > 20) {
      return 'The sun is scorching';
    } else if (temp < 10) {
      return 'it\'s quite cold  ';
    } else {
      return 'Bring a jacket just in case';
    }
  }
}
