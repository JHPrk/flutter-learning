// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:logging/logging.dart';
import 'package:open_weather_provider/exceptions/weather_exceptions.dart';
import 'package:open_weather_provider/models/custom_error.dart';
import 'package:open_weather_provider/models/direct_geocoding.dart';
import 'package:open_weather_provider/models/weather.dart';
import 'package:open_weather_provider/services/weather_api_services.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  static final _log = Logger('WeatherRepository');
  WeatherRepository({
    required this.weatherApiServices,
  });

  Future<Weather> fetchWeather(String city) async {
    try {
      final DirectGeocoding directGeocoding =
          await weatherApiServices.getDirectGeocoding(city);
      _log.fine(() => 'directGeocoding: $directGeocoding');

      final Weather tempWeather =
          await weatherApiServices.getWeather(directGeocoding);

      _log.fine(() => 'tempWeather: $tempWeather');

      final Weather weather = tempWeather.copyWith(
          name: directGeocoding.name, country: directGeocoding.country);

      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
