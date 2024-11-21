// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import 'package:open_weather_provider/models/custom_error.dart';
import 'package:open_weather_provider/repositories/weather_repository.dart';

import '../../models/weather.dart';

part 'weather_state.dart';

class WeatherProvider with ChangeNotifier {
  WeatherState _state = WeatherState.initial();
  WeatherState get state => _state;
  static final _log = Logger('WeatherProvider');

  final WeatherRepository weatherRepository;
  WeatherProvider({
    required this.weatherRepository,
  });

  Future<void> fetchWeather(String city) async {
    _state = _state.copyWith(status: WeatherStatus.loading);
    notifyListeners();

    try {
      final Weather weather = await weatherRepository.fetchWeather(city);

      _state = _state.copyWith(status: WeatherStatus.loaded, weather: weather);
      _log.info('state : $state');
      notifyListeners();
    } on CustomError catch (e) {
      _state = _state.copyWith(status: WeatherStatus.error, error: e);
      _log.info('state : $state');
      notifyListeners();
    }
  }
}
