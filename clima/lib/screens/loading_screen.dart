// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print, prefer_const_constructors, use_build_context_synchronously

import 'package:clima/screens/location_screen.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getlocationData() async {
     
   var weatherData = await WeatherModel().getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: ((context) {
      return LocationScreen(
        locationweather: weatherData,
      );
    })));
    // http.Response response = await http.get(Uri.parse(
    //     'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=00d7cef67e0677079cee456d30a7d402'));
    // if (response.statusCode == 200) {
    //   String data = response.body;

    //   double temprature = jsonDecode(data)['main']['temp'];
    //   int condition = jsonDecode(data)['weather'][0]['id'];
    //   String cityname = jsonDecode(data)['name'];
    //  print(temprature);
    //  print(condition);
    //   print(cityname);
    // } else {
    //   print(response.statusCode);
    // }

    // Navigator.push(
    //     context, MaterialPageRoute(builder: ((context) => LocationScreen(locationweather: getlocationData,))));
  }

  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    getlocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 100,
        
        ),
      ),
    );
  }
}
