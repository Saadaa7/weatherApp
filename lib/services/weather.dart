import 'package:clima/screens/city_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'location.dart';
import 'networking.dart';


double? latitude;
double? longitude;

const apiKey = '836508e87b8486fb88fdfff58ff37466';
const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';
// https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=apiKey
class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async{
    var uri = Uri.parse('$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=metric');
    NetworkHelper networkHelper = NetworkHelper(url: uri);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getWeatherLocation() async{
    Location location = Location();
    print('Before checkPerm');
    await location.checkPerm();
    print('After checkPerm');
    await location.getCurrentlocation();
    print('after getting current location');
    latitude= location.lat;
    longitude = location.long;
    print(latitude);
    print(longitude);

    var uri = Uri.parse('$openWeatherMapUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');


    NetworkHelper networkHelper = NetworkHelper(url: uri );
    // await networkHelper.getData();
    // var weatherData =
     var weatherData = await networkHelper.getData();
    print('got the weather data');
     return weatherData;

  }


  IconData getWeatherIcon(int condition) {
    if (condition < 300) {
      return (WeatherIcons.thunderstorm);
        // '🌩';
    } else if (condition < 400) {
      return (WeatherIcons.showers);
        '🌧';
    } else if (condition < 600) {
      return (WeatherIcons.rain);
        '☔️';
    } else if (condition < 700) {
      return (WeatherIcons.snow);
        // '☃️';
    } else if (condition < 800) {
      return  (WeatherIcons.smoke);
        // '🌫';
    } else if (condition == 800) {
      return (WeatherIcons.day_sunny);
        // '☀️';
    } else if (condition <= 804) {
      return (WeatherIcons.cloud);
        '☁️';
    } else {
      return (WeatherIcons.cloud);
        '🤷‍';
    }
  }

  String getMessage(int temp) {
    if(temp > 40){
      return 'It\'s too much sunny';
    }
    else if (temp > 30) {
      return 'It\'s clear sky  ';
    }
    else if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  String getBackgroundImage(int condition){
    if (condition < 300) {
      return 'storm-clouds';
      // '🌩';
    } else if (condition < 400) {
      return 'rain';
      '🌧';
    } else if (condition < 600) {
      return 'rain';
      '☔️';
    } else if (condition < 700) {
      return 'location_background';
      // '☃️';
    } else if (condition < 800) {
      return  'clouds';
      // '🌫';
    } else if (condition == 800) {
      return 'sunnyday';
      // '☀️';
    } else if (condition <= 804) {
      return 'clear';
      '☁️';
    } else {
      return 'location_background';
      '🤷‍';
    }
  }

}
