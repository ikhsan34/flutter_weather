// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter_weather/models/weather_model.dart';
import 'package:http/http.dart' as http;

class APIService {
  final String _url = 'https://api.openweathermap.org/data/2.5';
  final String _apiKey = '360f2c6ac06850e2540efce7f11d1dd3';

  Future<WeatherModel?> getWeather({required Coordinate coordinate}) async {
    final lat = coordinate.lat;
    final lon = coordinate.lon;

    try {
      final response = await http.get(Uri.parse('$_url/weather?lat=$lat&lon=$lon&appid=$_apiKey'));
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(json.decode(response.body));
      } else {
        print('Error: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load weather data');
    }
  }

  Future<List<WeatherModel>> getWeatherForecast({required Coordinate coordinate}) async {
    final lat = coordinate.lat;
    final lon = coordinate.lon;

    try {
      final response = await http.get(Uri.parse('$_url/forecast?lat=$lat&lon=$lon&appid=$_apiKey'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['list'] as List).map((e) => WeatherModel.fromJson(e)).toList();
      } else {
        print('Error: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load weather data');
    }
  }
}
