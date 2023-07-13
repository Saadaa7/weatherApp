import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import '../utilities/constants.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:glassmorphism/glassmorphism.dart';


class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {


  int? temprature;
  String? weatherdesc;
  IconData? weatherIcon;
  String? weatherMessage;
  String? city;
  String? country;
  String backgroundImage = 'location_background';
  WeatherModel weatherModel = WeatherModel();
  void UpdateUi(var weatherData){

    print(weatherData);
    setState(() {
      if (weatherData != null) {
        // if (weatherData['weather'] != null && weatherData['weather'].isNotEmpty) {
        var condition = weatherData['weather'][0]['id'];
        backgroundImage = weatherModel.getBackgroundImage(condition);
        weatherIcon = weatherModel.getWeatherIcon(condition);
        // }

        var description = weatherData['weather'][0]['description'];
        weatherdesc = description;

        // if (weatherData['main'] != null) {
        double temp = weatherData['main']['temp'];
        temprature = temp.toInt();
        weatherMessage = weatherModel.getMessage(temprature!);
        // }

        // if (weatherData['name'] != null) {
        city = weatherData['name'];
        // }
      }

      else {
        // Handle the case when weatherData is null
        // Set appropriate default or error values
        print('weather data may be null');
        String weatheri = weatherIcon as String;
        weatheri = 'Error';
        weatherMessage = 'unable to get weather data';
        city = '';

        return;
      }
    });

    // weather = weatherData['weather'][0]['id'];
    // double temp = weatherData['main']['temp'];
    // temprature = temp.toInt();
    // city = weatherData['name'];
    // country= weatherData['sys']['country'];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.locationWeather);
    UpdateUi(widget.locationWeather);
    print('$weatherIcon');


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:  AssetImage('images/$backgroundImage.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async{

                      var weatherData = await weatherModel.getWeatherLocation();
                      UpdateUi(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                     var typedNamed = await Navigator.push(context, MaterialPageRoute(builder: (context)=> CityScreen()));
                     // print(typedNamed);
                     if(typedNamed == null){
                       print('you haven\'t added any city name');
                       return;

                     }
                     else{
                       WeatherModel weatheCity = WeatherModel();
                     var weatherData =  await weatheCity.getCityWeather(typedNamed);
                       UpdateUi(weatherData);
                     }

                    },
                    child: const Icon(
                      Icons.location_city,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
               Center(
                 child: GlassmorphicContainer(
                   width: 350,
                   height: 200,
                   blur: 5,
                   border: 2,
                   borderRadius: 20,
                   linearGradient: LinearGradient(
                       begin: Alignment.topLeft,
                       end: Alignment.bottomRight,
                       colors: [
                         Color(0xFFffffff).withOpacity(0.1),
                         Color(0xFFFFFFFF).withOpacity(0.05),
                       ],
                       stops: [
                         0.1,
                         1,
                       ]),
                   borderGradient: LinearGradient(
                     begin: Alignment.topLeft,
                     end: Alignment.bottomRight,
                     colors: [
                       Color(0xFFffffff).withOpacity(0.5),
                       Color((0xFFFFFFFF)).withOpacity(0.5),
                     ],
                   ),
                   child: Center(
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Row(
                           mainAxisSize: MainAxisSize.min,
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: <Widget>[
                             Text(
                               // '32',
                               '$temprature°',
                               style: kTempTextStyle,
                             ),

                             Icon(
                               weatherIcon,
                               size: 60.0,
                               // '☀️',
                               // style: kConditionTextStyle,
                             ),
                           ],
                         ),
                         Text('$weatherdesc'.toUpperCase(),
                         style:kweatherDescTextStyle),
                       ],
                     ),
                   ),
                 ),
               ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$weatherMessage \n in $city',
                    // "It's 🍦 time in San Francisco!",
                    textAlign: TextAlign.center,
                    style: kMessageTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
