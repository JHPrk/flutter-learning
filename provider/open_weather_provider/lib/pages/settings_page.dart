import 'package:flutter/material.dart';
import 'package:open_weather_provider/providers/temp_settings/temp_settings_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: Text('Temperature Unit'),
          subtitle: Text('Celcius/Fahrenheit (Default: Celcius)'),
          trailing: Switch(
            value:
                context.watch<TempSettingsState>().tempUnit == TempUnit.celcius,
            onChanged: (_) {
              context.read<TempSettingsProvider>().toggleTempUnit();
            },
          ),
        ),
      ),
    );
  }
}
