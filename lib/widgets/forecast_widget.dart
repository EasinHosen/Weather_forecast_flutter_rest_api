import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/models/forecast_response_model.dart';
import 'package:weather_forecast/provider/weather_provider.dart';
import 'package:weather_forecast/utils/helper_function.dart';
import 'package:weather_forecast/utils/text_styles.dart';

import '../utils/constants.dart';

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({this.responseForecast, Key? key}) : super(key: key);

  final ForecastResponseModel? responseForecast;

  @override
  Widget build(BuildContext context) {
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: responseForecast!.list!.length,
      itemBuilder: (context, index) {
        final item = responseForecast!.list![index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.black38.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    getFormattedDateTime(item.dt!, 'EEE, MMM dd'),
                    style: txtNormal16,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    getFormattedDateTime(item.dt!, 'hh:mm a'),
                    style: txtNormal12,
                  ),
                  Image.network(
                    '$iconPrefix${item.weather![0].icon}$iconSuffix',
                  ),
                  FittedBox(
                    child: Text(
                      item.weather![0].description!,
                      style: txtNormal16,
                    ),
                  ),
                  Text(
                    '${item.main!.temp!.round()} $degree ${weatherProvider.unitSymbol}',
                    style: txtNormal16,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
