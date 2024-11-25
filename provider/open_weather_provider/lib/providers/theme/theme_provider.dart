// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:open_weather_provider/constants/constants.dart';
import 'package:open_weather_provider/providers/weather/weather_provider.dart';

part 'theme_state.dart';

class ThemeProvider {
  final WeatherProvider wp;
  ThemeProvider({
    required this.wp,
  });

  ThemeState get state {
    if (wp.state.weather.temp > kWarmOrNot) {
      return ThemeState();
    } else {
      return ThemeState(appTheme: AppTheme.dark);
    }
  }
}
