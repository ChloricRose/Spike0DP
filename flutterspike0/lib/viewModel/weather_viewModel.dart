import 'package:flutter/foundation.dart';

import '../model/weather_model.dart';
import '../services/weather_service.dart';

class WeatherViewModel with ChangeNotifier {
  final WeatherService _service;

  WeatherViewModel({WeatherService? service})
      : _service = service ?? WeatherService();

  WeatherModel? _weather;

  WeatherModel? get weather => _weather;

  Future<void> getWeather(String location) async {
    try {
      final result = await _service.getWeather(location);
      _weather = result;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}