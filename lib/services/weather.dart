import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather3/models/forecast.dart';

import '../models/main_models/weather_current.dart';
import '../models/main_models/weather_forecast.dart';

class WeatherServis {
  static const String _url =
      'http://api.weatherapi.com/v1/forecast.json?key=91e2fec1b4534ab695c81701222010&q=bursa&days=7&aqi=no&alerts=no';

  static Future<List<CurrentWeather>> getserviceWeather() async {
    List<CurrentWeather> _list = [];
    var result = await Dio().get(_url);
    debugPrint(result.toString());

    return _list;
  }
}
