// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, avoid_print,, unnecessary_string_interpolations

import 'dart:ffi';

import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  final locationweather;
  LocationScreen({this.locationweather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temprature;
  String weathericon;
  String cityname;
  String weathermessage;

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temprature = 0;
        weathericon = 'ERROR';
        weathermessage = 'Unable to get weather';
        cityname = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temprature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weathericon = weather.getWeatherIcon(condition);
      weathermessage = weather.getMessage(temprature);
      cityname = weatherData['name'];
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationweather);
    print(temprature);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/pages.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedname = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) {
                            return CityScreen();
                          }),
                        ),
                      );
                      if (typedname != null) {
                        var weatherData =
                            await weather.getcityweather(typedname);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temprature °',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weathericon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weathermessage in $cityname!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
