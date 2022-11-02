import 'package:weather3/models/current.dart';
import 'package:weather3/models/location.dart';

import '../../model/current.dart';

class CurrentWeather {
  Location? location;
  Current? current;

  CurrentWeather({this.location, this.current});

  CurrentWeather.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    current =
        json['current'] != null ? Current.fromJson(json['current']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (current != null) {
      data['current'] = current!.toJson();
    }
    return data;
  }
}
