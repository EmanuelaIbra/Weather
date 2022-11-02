import 'package:flutter/material.dart';
import 'package:http/http.dart' show Response, get;
import 'package:weather3/models/forecast.dart';
import 'package:weather3/models/main_models/weather_forecast.dart';
import 'package:weather3/pages/SevenDays.dart';
import 'package:weather3/pages/weatherapi.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _gelencevap;
  late final forecast;

  @override
  Widget build(BuildContext context) {
    weatherapi api = new weatherapi();

    return Scaffold(
      body: Container(
        child: FutureBuilder<ForecastWeather>(
          future: api.weather(),
          builder: (context, snapshot) {
            return hours(snapshot: snapshot);
          },
        ),
      ),
    );
  }
}

class hours extends StatelessWidget {
  final AsyncSnapshot<ForecastWeather> snapshot;
  const hours({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (snapshot.data == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Container(
      height: 690,
      width: 500,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            Colors.pinkAccent.shade100,
            Colors.deepPurpleAccent.shade200,
            Colors.indigo.shade400,
          ])),
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              height: 150,
              width: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.network(
                    'http:${snapshot.data!.current!.condition!.icon.toString()}',
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${snapshot.data!.location!.region.toString()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${snapshot.data!.current!.tempC.toString()} °C    ${snapshot.data!.current!.condition!.text.toString()}',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                ],
              ),
            ),
            /*Text(
              '${snapshot.data!.current!.tempC.toString()} C',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),*/
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white10),
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'Humidity : ${snapshot.data!.current!.humidity.toString()} %',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white10),
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'Sunrise : ${snapshot.data!.forecast!.forecastday![0].astro!.sunrise.toString()}',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white10),
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'UV : ${snapshot.data!.current!.uv.toString()} %',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white10),
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'Sunset : ${snapshot.data!.forecast!.forecastday![0].astro!.sunset.toString()}',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '   Today',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return SevenDays();
                    }));
                  },
                  child: Row(
                    children: [
                      Text(
                        "7 Days Info ",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.white,
                        size: 15,
                      )
                    ],
                  ),
                )
              ],
            ),
            Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        snapshot.data!.forecast!.forecastday![0].hour!.length,
                    itemBuilder: (BuildContext context, int index) {
                      /*    .data!.forecast!.forecastday![index].date
                          .toString());

                      print(DateFormat('EEEE').format(dt));*/

                      return Container(
                        margin: EdgeInsets.only(bottom: 20),
                        width: 70,
                        child: Card(
                          elevation: 0,
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
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  // '${snapshot.data!.forecast!.forecastday![index].date}',
                                  '${snapshot.data!.forecast!.forecastday![0].hour![index].time!.substring(10, 16)}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.0),
                                ),
                                Container(
                                  height: 50,
                                  child: Image.network(
                                      'http:${snapshot.data!.forecast!.forecastday![0].hour![index].condition!.icon.toString()}'),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        '${snapshot.data!.forecast!.forecastday![0].hour![index].tempC.toString()} °C',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data!.forecast!.forecastday![0].hour![index].condition!.text.toString()}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
