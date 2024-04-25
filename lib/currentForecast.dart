import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class CurrentWeather extends StatelessWidget {
  final String cityName;
  final String weatherStatus;
  final double temperature;
  final double windSpeed;
  final int humidity;

  CurrentWeather({
    required this.cityName,
    required this.weatherStatus,
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[

        SizedBox(height: 80,),
        Icon(
          getWeatherIcon(weatherStatus),
          size: 70,
          color: Colors.orangeAccent[100],// Цвет иконки

        ),
        SizedBox(height: 20,),
        TextLiquidFill(
          waveDuration: Duration(milliseconds: 1000),
          loadDuration: Duration(milliseconds: 2700),
          text:cityName,
          boxWidth: 2000,
          waveColor: Colors.orangeAccent,
          boxBackgroundColor: Colors.white,
          textStyle: TextStyle(
            fontSize: 100.0,
            fontWeight: FontWeight.w400,
          ),
          boxHeight: 200.0,
        ),
         // Пробел между названием города и иконкой

        SizedBox(height: 20), // Пробел между иконкой и информацией о погоде
        Text(
          'Состояние: $weatherStatus',
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30,color: Colors.blueGrey[600]),
        ),
        SizedBox(height: 20),
        Text(
          'Температура: $temperature °C',
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20,color: Colors.blueGrey[600]),
        ),
        SizedBox(height: 20),
        Text(
          'Скорость ветра: $windSpeed м/с',
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20,color: Colors.blueGrey[600]),
        ),
        SizedBox(height: 20),
        Text(
          'Влажность: $humidity %',
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20,color: Colors.blueGrey[600]),

        ),
      ],
    );
  }

  IconData getWeatherIcon(String weatherStatus) {
    switch (weatherStatus.toLowerCase()) {      // в зависимости от статуса иконка
      case 'clear sky':
        return Icons.wb_sunny;
      case 'overcast clouds':
        return Icons.cloud;
      case 'broken clouds':
        return Icons.cloud;
      case 'scattered clouds':
        return Icons.cloud;
      case 'moderate rain':
        return Icons.beach_access_outlined;
      case 'light rain':
        return Icons.beach_access;
      default:
        return Icons.wb_cloudy;
    }
  }
}
