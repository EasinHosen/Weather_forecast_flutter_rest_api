import 'package:flutter/material.dart';
import 'package:weather_forecast/models/current_response_model.dart';
import 'package:weather_forecast/utils/helper_function.dart';
import 'package:weather_forecast/utils/text_styles.dart';

import '../utils/constants.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({this.responseCurrent, Key? key}) : super(key: key);

  final CurrentResponseModel? responseCurrent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: Row(
            children: [
              Text(
                getFormattedDateTime(responseCurrent!.dt!, 'MMM dd, yyyy'),
                style: txtNormal16,
              ),
              const SizedBox(
                width: 5,
              ),
              Image.network(
                '$iconPrefix${responseCurrent!.weather![0].icon}$iconSuffix',
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            responseCurrent!.weather![0].main!,
            style: const TextStyle(fontSize: 40, color: Colors.white),
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
          '${responseCurrent!.wind!.speed} m/s',
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
