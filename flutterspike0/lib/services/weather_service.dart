import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/weather_model.dart';

class WeatherService {
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';
  static const String _apiKey = '9067f8054b718909b3849307f3c05085';

  final http.Client _client;

  WeatherService({http.Client? client}) : _client = client ?? http.Client();

  Future<WeatherModel> getWeather(String location) async {
    final uri = Uri.parse('$_baseUrl?q=$location&units=metric&appid=$_apiKey');

    final response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to retrieve weather data');
    }

    final json = jsonDecode(response.body);
    print(json);

    final temperature = json['main']['temp'];
    final precipitation = json['weather'][0]['description'];

    return WeatherModel(
      temperature: temperature,
      precipitation: precipitation,
    );
  }
}