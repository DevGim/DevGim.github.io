import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/bundang_beauty.dart';
import '../data/bundang_food.dart';

const MaterialColor iconColorBeauty = Colors.red;
const MaterialColor iconColorFood = Colors.blue;

const double iconSize = 40;

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('성남시 아동수당 신한카드 사용처'),
      ),
      body: const FlutterApp(),
    );
  }
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    // bundangFood와 bundangBeauty 데이터를 합침
    List<Marker> allMarkers = [
      ...bundangFood.map((markerInfo) => Marker(
            width: 200,
            height: iconSize + 21,
            point: LatLng(markerInfo.latitude, markerInfo.longitude),
            child: Column(
              children: [
                const Icon(
                  Icons.location_pin,
                  color: iconColorFood,
                  size: iconSize,
                ),
                Text(markerInfo.storeName),
              ],
            ),
          )),
      ...bundangBeauty.map((markerInfo) => Marker(
            width: 200,
            height: iconSize + 21,
            point: LatLng(markerInfo.latitude, markerInfo.longitude),
            child: Column(
              children: [
                const Icon(
                  Icons.location_pin,
                  color: iconColorBeauty,
                  size: iconSize,
                ),
                Text(markerInfo.storeName),
              ],
            ),
          )),
    ];

    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(37.411549, 127.1298651),
        initialZoom: 14.5,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: allMarkers, // 합쳐진 마커 리스트를 사용
        ),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () =>
                  launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
            ),
          ],
        ),
      ],
    );
  }
}
