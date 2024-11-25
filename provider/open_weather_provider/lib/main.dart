import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:logging/logging.dart';
import 'package:open_weather_provider/pages/home_page.dart';
import 'package:open_weather_provider/providers/providers.dart';
import 'package:open_weather_provider/providers/weather/weather_provider.dart';
import 'package:open_weather_provider/repositories/weather_repository.dart';
import 'package:open_weather_provider/services/weather_api_services.dart';
import 'dart:developer' as dev;
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() async {
  await dotenv.load(fileName: '.env');
  Logger.root.level = kDebugMode ? Level.FINE : Level.INFO;
  Logger.root.onRecord.listen((record) {
    dev.log(record.message,
        time: record.time, level: record.level.value, name: record.loggerName);
  });
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<WeatherRepository>(
          create: (context) => WeatherRepository(
            weatherApiServices: WeatherApiServices(
              httpClient: http.Client(),
            ),
          ),
        ),
        StateNotifierProvider<WeatherProvider, WeatherState>(
          create: (context) => WeatherProvider(),
        ),
        StateNotifierProvider<TempSettingsProvider, TempSettingsState>(
          create: (context) => TempSettingsProvider(),
        ),
        StateNotifierProvider<ThemeProvider, ThemeState>(
          create: (context) => ThemeProvider(),
        )
      ],
      builder: (context, _) => MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: context.watch<ThemeState>().appTheme == AppTheme.light
            ? ThemeData.light()
            : ThemeData.dark(),
        home: const HomePage(),
      ),
    );
  }
}
