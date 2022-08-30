// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:weather_forecast/utils/text_styles.dart';
// import 'package:weather_forecast/widgets/details_widget.dart';
// import 'package:weather_forecast/widgets/sun_and_country_details.dart';
// import 'package:weather_forecast/widgets/temp_widget.dart';
//
// class TestPage extends StatelessWidget {
//   static const String routeName = '/test_page';
//   const TestPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: const Icon(Icons.menu),
//       ),
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topRight,
//                 end: Alignment.bottomLeft,
//                 stops: const [0.2, 0.5, 0.8, 0.7],
//                 colors: [
//                   Colors.blue[50]!,
//                   Colors.blue[100]!,
//                   Colors.blue[200]!,
//                   Colors.blue[300]!,
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: SafeArea(
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: const [
//                       Center(
//                           child: Text(
//                         'Dhaka',
//                         style: txtNormal16,
//                       )),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 6.0),
//                         child: Icon(
//                           Icons.location_on,
//                           size: 30,
//                           color: Colors.black38,
//                         ),
//                       )
//                     ],
//                   ),
//                   StaggeredGrid.count(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 20,
//                     children: [
//                       StaggeredGridTile.count(
//                         crossAxisCellCount: 1,
//                         mainAxisCellCount: 2,
//                         child: Card(
//                           color: Colors.blue.withOpacity(0.1),
//                           // elevation: 5,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: DetailsWidget(),
//                         ),
//                       ),
//                       StaggeredGridTile.count(
//                         crossAxisCellCount: 1,
//                         mainAxisCellCount: 1,
//                         child: Card(
//                           color: Colors.red.withOpacity(0.2),
//                           // elevation: 5,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15)),
//                           child: TempWidget(),
//                         ),
//                       ),
//                       StaggeredGridTile.count(
//                         crossAxisCellCount: 1,
//                         mainAxisCellCount: 1,
//                         child: Card(
//                           color: Colors.yellowAccent.withOpacity(0.3),
//                           elevation: 5,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15)),
//                           child: const SunAndCountryDetails(),
//                         ),
//                       ),
//                       StaggeredGridTile.count(
//                         crossAxisCellCount: 2,
//                         mainAxisCellCount: 1,
//                         child: Card(
//                           color: Colors.yellowAccent.withOpacity(0.3),
//                           elevation: 5,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15)),
//                           child: const SunAndCountryDetails(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
