import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather3/pages/weatherapi.dart';

import '../models/main_models/weather_forecast.dart';

class SevenDays extends StatefulWidget {
  const SevenDays({Key? key}) : super(key: key);

  @override
  State<SevenDays> createState() => _SevenDaysState();
}

class _SevenDaysState extends State<SevenDays> {
  @override
  Widget build(BuildContext context) {
    weatherapi api1 = new weatherapi();
    var snapshot;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Colors.pinkAccent.shade100,
              Colors.deepPurpleAccent.shade200,
              Colors.indigo.shade400,
            ])),
        child: FutureBuilder<ForecastWeather>(
          future: api1.weather(),
          builder: (context, snapshot) {
            return sevendays(snapshot: snapshot);
          },
        ),
      ),
    );
  }
}

class sevendays extends StatelessWidget {
  final AsyncSnapshot<ForecastWeather> snapshot;
  const sevendays({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (snapshot.data == null) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
        shrinkWrap: true,
        itemCount: snapshot.data!.forecast!.forecastday!.length,
        itemBuilder: (BuildContext context, int index) {
          DateTime dt = DateTime.parse(
              snapshot.data!.forecast!.forecastday![index].date.toString());

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            height: 100, //MediaQuery.of(context).size.width * 0.6,
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.white10,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              color: Colors.transparent,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      DateFormat('EEEE').format(dt),
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                    Image.network(
                        'http:${snapshot.data!.forecast!.forecastday![index].day!.condition!.icon.toString()}'),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${snapshot.data!.forecast!.forecastday![index].day!.maxtempC.toString()} °C',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          'Max',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '  ${snapshot.data!.forecast!.forecastday![index].day!.mintempC.toString()} °C',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          '  Min',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );

          ListTile(
            title: Text('${snapshot.data!.forecast!.forecastday![index].date}'),
            subtitle: Text(
                '${snapshot.data!.forecast!.forecastday![index].hour![13].condition!.text}'),
          );
        });
  }
}
