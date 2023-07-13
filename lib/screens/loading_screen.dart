import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }



  Future<void> getLocationData() async {

    // Location location = Location();
    // print('Before checkPerm');
    // await location.checkPerm();
    // print('After checkPerm');
    // await location.getCurrentlocation();
    // print('after getting current location');
    // latitude= location.lat;
    // longitude = location.long;
    // print(latitude);
    // print(longitude);

    // var uri = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=836508e87b8486fb88fdfff58ff37466&units=metric');
    //
    //
    // NetworkHelper networkHelper = NetworkHelper(url: uri, );
    // await networkHelper.getData();
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getWeatherLocation();





    Navigator.push(context, MaterialPageRoute(builder: (context) {return LocationScreen(locationWeather: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    getLocationData();
    return  Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:  AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        child: Center(
          child: SpinKitDoubleBounce(
            color: Colors.white,
            size: 100.0,

          ),
        ),
      ),
    );

  }
}
