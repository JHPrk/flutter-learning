import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_provider/providers/weather/weather_provider.dart';
import 'package:open_weather_provider/repositories/weather_repository.dart';
import 'package:open_weather_provider/services/weather_api_services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Text('Home'),
      ),
    );
  }

  void _fetchWeather() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<WeatherProvider>().fetchWeather('london'));
  }
}
