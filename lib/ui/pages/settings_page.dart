import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/provider/weather_provider.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = '/settings_page';
  const SettingsPage({Key? key}) : super(key: key);

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
      body: Consumer<WeatherProvider>(
        builder: (context, provider, child) => ListView(
          padding: const EdgeInsets.all(8),
          children: [
            SwitchListTile(
              title: const Text('Set unit to Imperial'),
              value: provider.isFahrenheit,
              onChanged: (val) async {
                provider.setTempUnit(val);
                await provider.setPreferenceTempUitValue(val);
                provider.getWeatherData();
              },
            ),
          ],
        ),
      ),
    );
  }
}
