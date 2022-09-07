import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/provider/weather_provider.dart';
import 'package:weather_forecast/ui/pages/settings_page.dart';
import 'package:weather_forecast/utils/constants.dart';
import 'package:weather_forecast/utils/location_utils.dart';
import 'package:weather_forecast/utils/text_styles.dart';

import '../../widgets/details_widget.dart';
import '../../widgets/forecast_widget.dart';
import '../../widgets/sun_and_country_details.dart';
import '../../widgets/temp_widget.dart';

class WeatherPage extends StatefulWidget {
  static const String routeName = '/weather_page';
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late WeatherProvider weatherProvider;
  bool isFirst = true;

  @override
  void didChangeDependencies() {
    if (isFirst) {
      weatherProvider = Provider.of<WeatherProvider>(context);
      _getData();
      isFirst = false;
    }
    super.didChangeDependencies();
  }

  _getData() async {
    final locationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationEnabled) {
      EasyLoading.showToast('Location is disabled');
      await Geolocator.getCurrentPosition();
      _getData();
    }
    try {
      final position = await determinePosition();
      weatherProvider.setNewLocation(position.latitude, position.longitude);
      weatherProvider
          .setTempUnit(await weatherProvider.getPreferenceTempUnitValue());
      weatherProvider.getWeatherData();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final responseCurrent = weatherProvider.currentResponseModel;
    final responseForecast = weatherProvider.forecastResponseModel;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                _getData();
              },
              icon: const Icon(
                Icons.my_location,
                color: Colors.black38,
              )),
          IconButton(
              onPressed: () async {
                final result = await showSearch(
                    context: context, delegate: _CitySearchDelegate());
                if (result != null && result.isNotEmpty) {
                  // print(result);
                  weatherProvider.convertAddressToLatLong(result);
                }
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black38,
              )),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SettingsPage.routeName);
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.black38,
              )),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: const [0.2, 0.5, 0.8, 0.7],
                colors: [
                  Colors.blue[50]!,
                  Colors.blue[100]!,
                  Colors.blue[200]!,
                  Colors.blue[300]!,
                ],
              ),
            ),
          ),
          weatherProvider.hasDataLoaded
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SafeArea(
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      children: [
                        StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: 2.4,
                          child: Card(
                            color: Colors.blue.withOpacity(0.1),
                            // elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child:
                                DetailsWidget(responseCurrent: responseCurrent),
                          ),
                        ), //details widget
                        StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: 1.2,
                          child: Card(
                            color: Colors.yellowAccent.withOpacity(0.1),

                            // elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: SunAndCountryDetails(
                              responseCurrent: responseCurrent,
                            ),
                          ),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: 1.2,
                          child: Card(
                            color: Colors.red.withOpacity(0.2),
                            // elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: TempWidget(
                              responseCurrent: responseCurrent,
                            ),
                          ),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 1,
                          child: Card(
                            color: Colors.greenAccent.withOpacity(0.3),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: ForecastWidget(
                              responseForecast: responseForecast,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: Text(
                    'Fetching Data...',
                    style: txtHeader20,
                  ),
                ),
        ],
      ),
    );
  }
}

class _CitySearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: const Icon(Icons.clear));
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.search),
      title: Text(query),
      onTap: () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredList = query.isEmpty
        ? cities
        : cities
            .where((city) => city.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(filteredList[index]),
        onTap: () {
          query = filteredList[index];
          close(context, query);
        },
      ),
    );
  }
}
