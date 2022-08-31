import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/models/current_response_model.dart';
import 'package:weather_forecast/utils/helper_function.dart';
import 'package:weather_forecast/utils/text_styles.dart';

import '../provider/weather_provider.dart';
import '../utils/constants.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({this.responseCurrent, Key? key}) : super(key: key);

  final CurrentResponseModel? responseCurrent;

  @override
  Widget build(BuildContext context) {
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          getFormattedDateTime(responseCurrent!.dt!, 'MMM dd, yyyy'),
          style: txtHeader20,
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            getFormattedDateTime(responseCurrent!.dt!, 'EEEE'),
            style: txtNormal16,
          ),
        ),
        FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              responseCurrent!.weather![0].main!,
              style: const TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
        ),
        Image.network(
          '$iconPrefix${responseCurrent!.weather![0].icon}$iconSuffix',
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            responseCurrent!.weather![0].description!,
            style: txtNormal16,
          ),
        ),
        const Divider(
          endIndent: 20,
          indent: 20,
          height: 1,
          color: Colors.white,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Wind',
          style: txtHeader20,
        ),
        Text(
          '${responseCurrent!.wind!.speed} ${weatherProvider.windSpeed}',
          style: txtNormal16,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Humidity',
          style: txtHeader20,
        ),
        Text(
          '${responseCurrent!.main!.humidity}%',
          style: txtNormal16,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Pressure',
          style: txtHeader20,
        ),
        Text(
          '${responseCurrent!.main!.pressure} hPa',
          style: txtNormal16,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
