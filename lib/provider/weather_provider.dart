import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart' as Geo;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_forecast/models/current_response_model.dart';
import 'package:weather_forecast/models/forecast_response_model.dart';
import 'package:weather_forecast/utils/constants.dart';

class WeatherProvider extends ChangeNotifier {
  CurrentResponseModel? currentResponseModel;
  ForecastResponseModel? forecastResponseModel;
  double latitude = 0.0, longitude = 0.0;
  String unit = metric;
  String unitSymbol = celsius;
  String windSpeed = windSpeedMetric;

  bool get hasDataLoaded =>
      currentResponseModel != null && forecastResponseModel != null;

  bool get isFahrenheit => unit == imperial;

  void setNewLocation(double lat, double lon) {
    latitude = lat;
    longitude = lon;
  }

  getWeatherData() {
    _getCurrentData();
    _getForecastData();
  }

  void _getCurrentData() async {
    final uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=$unit&appid=$weatherApiKey');

    try {
      final response = await get(uri);
      final map = jsonDecode(response.body);

      // print(response.body);

      if (response.statusCode == 200) {
        currentResponseModel = CurrentResponseModel.fromJson(map);
        notifyListeners();
      } else {
        print(map['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  void _getForecastData() async {
    final uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&units=$unit&appid=$weatherApiKey');

    try {
      final response = await get(uri);
      final map = jsonDecode(response.body);

      if (response.statusCode == 200) {
        forecastResponseModel = ForecastResponseModel.fromJson(map);
        notifyListeners();
      } else {
        print(map['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  void setTempUnit(bool tag) {
    unit = tag ? imperial : metric;
    unitSymbol = tag ? fahrenheit : celsius;
    windSpeed = tag ? windSpeedImperial : windSpeedMetric;
    notifyListeners();
  }

  Future<bool> setPreferenceTempUitValue(bool tag) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setBool('unit', tag);
  }

  Future<bool> getPreferenceTempUnitValue() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool('unit') ?? false;
  }

  convertAddressToLatLong(String result) async {
    try {
      final locationList = await Geo.locationFromAddress(result);
      if (locationList.isNotEmpty) {
        final location = locationList.first;
        setNewLocation(location.latitude, location.longitude);
        getWeatherData();
        // latitude = location.latitude;
        // longitude = location.longitude;
      } else {
        EasyLoading.showToast('City not found');
      }
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }
}
