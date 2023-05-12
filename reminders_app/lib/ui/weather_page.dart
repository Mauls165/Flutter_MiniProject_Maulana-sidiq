import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/weather.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  List<WeatherData> weatherDataList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWeatherData().then((data) {
      setState(() {
        weatherDataList = data;
      });
    });
  }

  Future<List<WeatherData>> fetchWeatherData() async {
    const String apikey = '23e2347b6dff432e8e4125318231205';
    final apiUrl = Uri.parse(
        'https://api.weatherapi.com/v1/forecast.json?key=$apikey&q=Bandung&days=6');
    final response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final forecastData = jsonData['forecast']['forecastday'];
      List<WeatherData> dataList = [];
      for (var data in forecastData) {
        dataList.add(WeatherData.fromJson(data));
      }
      return dataList;
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Page'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(), // Tampilkan animasi loading
            )
          : ListView.builder(
              itemCount: weatherDataList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Image.network(weatherDataList[index].iconUrl),
                    title: Text(weatherDataList[index].date),
                    subtitle: Text(weatherDataList[index].condition),
                    trailing: Text(weatherDataList[index].temperature),
                  ),
                );
              },
            ),
    );
  }
}
