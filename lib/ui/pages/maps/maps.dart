// import 'package:flutter/material.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';

// class SelectLocationScreen extends StatefulWidget {
//   @override
//   _SelectLocationScreenState createState() => _SelectLocationScreenState();
// }

// class _SelectLocationScreenState extends State<SelectLocationScreen> {
//   late YandexMapController _controller;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Yandex Maps')),
//       body: YandexMap(
//         onMapCreated: (controller) {
//           _controller = controller;

//           // Haritada markerni qo'shish
//           // _controller.(
//           //   point: Point(
//           //     latitude: 55.7558,
//           //     longitude: 37.6173,
//           //   ), // Moskvada joylashgan
//           //   icon: PlacemarkIcon.single(
//           //     PlacemarkIconStyle(
//           //       image: BitmapDescriptor.fromAssetImage('assets/marker.png'),
//           //     ),
//           //   ),
//           // );
//         },
//       ),
//     );
//   }
// }
