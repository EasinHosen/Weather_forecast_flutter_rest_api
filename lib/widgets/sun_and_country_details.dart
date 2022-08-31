import 'package:flutter/material.dart';
import 'package:weather_forecast/models/current_response_model.dart';

import '../utils/helper_function.dart';
import '../utils/text_styles.dart';

class SunAndCountryDetails extends StatelessWidget {
  const SunAndCountryDetails({this.responseCurrent, Key? key})
      : super(key: key);
  final CurrentResponseModel? responseCurrent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            responseCurrent!.sys!.country!,
            style: txtAddress24,
          ),
          FittedBox(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  responseCurrent!.name!,
                  style: txtHeader20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.0),
                  child: Icon(
                    Icons.location_on,
                    size: 25,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Sunrise ${getFormattedDateTime(responseCurrent!.sys!.sunrise!, 'hh:mm a')}',
            style: txtNormal16,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Sunset ${getFormattedDateTime(responseCurrent!.sys!.sunset!, 'hh:mm a')}',
            style: txtNormal16,
          ),
        ],
      ),
    );
  }
}
