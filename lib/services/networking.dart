import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper{
  //
  NetworkHelper({required this.url});
  var url;
  // NetworkHelper( lat, long){
  //   url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=836508e87b8486fb88fdfff58ff37466&units=metric');
  // }

  Future<dynamic> getData() async{
    // print(url);
    http.Response response = await http.get(url);

    if (response.statusCode == 200){
      String data = response.body;
      var decodeData = jsonDecode(data);
      // print(data);

      // print(weather);
      // print(temp);
      // print(city);
      // print(country);

      return decodeData;

    }
    else{
      print(response.statusCode);
    }

  }
}