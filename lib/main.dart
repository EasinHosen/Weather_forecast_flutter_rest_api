import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/provider/weather_provider.dart';
import 'package:weather_forecast/ui/pages/settings_page.dart';
import 'package:weather_forecast/ui/pages/weather_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.wave
      ..toastPosition = EasyLoadingToastPosition.bottom;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'MerriweatherSans',
        primarySwatch: Colors.blue,
      ),
      builder: EasyLoading.init(),
      initialRoute: WeatherPage.routeName,
      routes: {
        WeatherPage.routeName: (context) => WeatherPage(),
        SettingsPage.routeName: (context) => SettingsPage(),
        // TestPage.routeName: (context) => TestPage(),
      },
    );
  }
}
