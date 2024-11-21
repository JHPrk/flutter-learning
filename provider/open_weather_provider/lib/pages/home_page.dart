import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:open_weather_provider/pages/search_page.dart';
import 'package:open_weather_provider/providers/weather/weather_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final _log = Logger('HomePageState');
  String? _city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
              onPressed: () async {
                _city = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPage()));
                _log.fine("city : $_city");
                if (_city != null) {
                  context.read<WeatherProvider>().fetchWeather(_city!);
                }
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
