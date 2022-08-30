import 'package:flutter/material.dart';

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Card();
      },
    );
  }
}
