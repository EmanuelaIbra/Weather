import 'package:flutter/material.dart';
import 'package:http/http.dart' show Response, get;
import 'package:weather3/models/forecast.dart';
import 'package:weather3/models/main_models/weather_forecast.dart';
import 'package:weather3/pages/home_page.dart';
import 'dart:convert';

import 'package:weather3/services/forcast.dart';
import 'package:weather3/services/weather.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
