//   afff53e81810070f873cd36b1c755d21
import 'package:flutter/material.dart';
import 'package:weather_pro/mainWeatherScr.dart';

void main() {
  runApp(NetworkingApp());
}

class NetworkingApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Прогноз погоды',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        textTheme: TextTheme(
            headline6: TextStyle(fontSize: 26, fontWeight: FontWeight.w400,color: Colors.blueGrey[400]),
            subtitle1: TextStyle(fontSize: 21, fontStyle: FontStyle.italic, fontWeight: FontWeight.w300,color: Colors.blueGrey[500]),
            bodyText1: TextStyle(fontSize: 26,color: Colors.black, fontWeight: FontWeight.w300),
            bodyText2: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)
        ),
      ),
      home: WeatherScreen(),
    );
  }
}
