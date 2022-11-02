import 'dart:convert';
import 'package:http/http.dart' show Response, get;
import '../models/main_models/weather_forecast.dart';

class weatherapi {
  Future<ForecastWeather> weather() async {
    var adres =
        'https://api.weatherapi.com/v1/forecast.json?key=2e55a32f809042c6b42141047220111&q=bursa&days=7&aqi=no&alerts=no';
    Response cevap = await get(Uri.parse(adres));
    if (cevap.statusCode == 200) {
      var gelenJson = jsonDecode(cevap.body);

      ForecastWeather forecast = ForecastWeather.fromJson(gelenJson!);
      return forecast;
    } else {
      return ForecastWeather();
    }
  }
}
