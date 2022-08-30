import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/models/current_response_model.dart';
import 'package:weather_forecast/provider/weather_provider.dart';
import 'package:weather_forecast/utils/constants.dart';
import 'package:weather_forecast/utils/text_styles.dart';

class TempWidget extends StatelessWidget {
  const TempWidget({this.responseCurrent, Key? key}) : super(key: key);

  final CurrentResponseModel? responseCurrent;

  @override
  Widget build(BuildContext context) {
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0, top: 16),
          child: Text(
            'Temp',
            style: txtHeader20,
          ),
        ),
        Text(
          '${responseCurrent!.main!.temp!.round()}$degree${weatherProvider.unitSymbol}',
          style: txtTempBig50,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Feels like ${responseCurrent!.main!.feelsLike!.round()}$degree${weatherProvider.unitSymbol}',
          style: txtNormal16,
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'min: ${responseCurrent!.main!.tempMin!.round()}$degree${weatherProvider.unitSymbol}'),
              Text(
                  'max: ${responseCurrent!.main!.tempMin!.round()}$degree${weatherProvider.unitSymbol}'),
            ],
          ),
        ),
      ],
    );
  }
}
