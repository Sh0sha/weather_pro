import 'package:flutter/material.dart';
import 'package:weather_pro/currentForecast.dart';

class ForecastWeather extends StatelessWidget {
  final List<WeatherForecast> pogodaData;

  ForecastWeather({required this.pogodaData});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pogodaData.length,
      itemBuilder: (context, index) {
        if (index == 0 ||
            pogodaData[index].time.day != pogodaData[index - 1].time.day) {
          // Добавляем разделительную линию перед новой датой
          return Column(
            children: [
              ListTile(
                textColor: Colors.black54,
                title: Text(

                  '${pogodaData[index].time.day}/${pogodaData[index].time
                      .month}/${pogodaData[index].time.year}',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
              ),
              Divider(thickness: 2, color: Colors.black54),

              // разделительная линия
            ],
          );
        } else {
          return ListTile(
            title: Row(
              children: [
                Text(
                  '${pogodaData[index].time.hour}:00    -',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 25),
                Text(
                  '${pogodaData[index].temperature} °C',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            subtitle: Text(pogodaData[index].pogodaStatus),
            trailing:  Icon(getWeatherIcon(pogodaData[index].pogodaStatus,pogodaData[index].time.hour),size: 38,color: Colors.black54), // иконка состояния погоды
          );
        }
      },
    );
  }

  // Функция для получения иконки погоды в зависимости от времени суток
  IconData getWeatherIcon(String weatherStatus,int hour) {
    switch (weatherStatus.toLowerCase()) {
      case 'clear sky':
        return Icons.wb_sunny;
      case 'overcast clouds':
        return Icons.cloud;
      case 'broken clouds':
        return Icons.cloud;
      case 'scattered clouds':
        return Icons.cloud_circle_outlined;
      case 'moderate rain':
        return Icons.beach_access;
      case 'light rain':
        return Icons.beach_access;
      default:
        return Icons.wb_cloudy;
    }

  }
}

  class WeatherForecast {
  late DateTime time;
  late double temperature; // переменные которые действуют когда будут использованы
  late String pogodaStatus;

  WeatherForecast({
    required this.time,
    required this.temperature, // req необходимо обязательная передача при созд экземпл объекта
    required this.pogodaStatus,
  });
}
