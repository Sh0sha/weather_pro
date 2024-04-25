import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather_pro/currentForecast.dart';
import 'package:weather_pro/forecast.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late String apiKey = 'afff53e81810070f873cd36b1c755d21';
  late String city = 'Miami';
  late String pogodaStatus = '';
  late double temperature = 0.0;
  late double speedVeter = 0.0;
  late int vlaga = 0;
  late List<WeatherForecast> prognozData = [];
  final List<Map<String, String>> cities = [
    {'name': 'Moscow', 'code': 'Moscow'},
    {'name': 'London', 'code': 'London'},
    {'name': 'Tokyo', 'code': 'Tokyo'},
    {'name': 'Miami','code':'Miami'}
  ];
  Map<String, dynamic>? weatherData;

  @override
  void initState() {
    super.initState();
    getDataWeather();
    getPrognosData();
  }
/// получаем данные о погоде
  Future<void> getDataWeather() async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        pogodaStatus = data['weather'][0]['description'];
        temperature = data['main']['temp'];
        speedVeter = data['wind']['speed'];
        vlaga = data['main']['humidity'];
        weatherData = json.decode(response.body);

      });
    } else {
      throw Exception('Ошибкаa');
    }
  }

  Future<void> getPrognosData() async {
    final url ='https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));// выполнение get запроса к апи погоды

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> list = data['list'];
      setState(() {
        prognozData = list.map((e) => WeatherForecast(
          time: DateTime.fromMillisecondsSinceEpoch(e['dt'] * 1000),
          temperature: e['main']['temp'].toDouble(),
          pogodaStatus: e['weather'][0]['description'],
        )).toList();
      });
    } else {
      throw Exception('Ошибка загрузки');
    }
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title:  TextField(
            onChanged: (value) {
              city = value;
            },
            decoration: InputDecoration(

              hintText: 'введите город',
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                getDataWeather();     // вызываю методы при нажати на поиск
                getPrognosData();
              },
            ),
          ],
        ),
        body:

        TabBarView(
          children: [
            CurrentWeather(

              cityName: city,
              weatherStatus: pogodaStatus,
              temperature: temperature,
              windSpeed: speedVeter,
              humidity: vlaga,

            ),

            ForecastWeather(pogodaData: prognozData),

          ],
        ),
        drawer: Drawer(
          elevation: 5,
          width: 250,
          backgroundColor: Colors.orange[200],
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // ииконка состояния погоды
                  weatherData != null
                      ? Image.network(
                    'https://openweathermap.org/img/w/${weatherData!['weather'][0]['icon']}.png',
                    width: 60,
                    height: 50,
                  )
                      : SizedBox(),
                  SizedBox(width:10),
                  Text(
                    city,
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              for (var item in cities)
                ListTile(
                  title: Text(item['name']!),
                  onTap: () {
                    setState(() {
                      city = item['code']!;
                    });
                    getDataWeather();
                    getPrognosData();
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
