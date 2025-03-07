import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Home Page'),
      ),
      body: const FlutterApp(),
    );
  }
}

class FlutterApp extends StatelessWidget {
  // Define a list of marker information
  final List<MarkerInfo> markers = [
    MarkerInfo(
      latitude: 37.411549,
      longitude: 127.1298651,
      iconColor: Colors.red,
      iconSize: 40.0,
      text: "Marker 1",
    ),
    MarkerInfo(
      latitude: 37.376703,
      longitude: 127.116195,
      iconColor: Colors.blue,
      iconSize: 40.0,
      text: "Marker 2",
    ),
    // Add more markers as needed
  ];

  FlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
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
          markers: markers
              .map((markerInfo) => Marker(
                    width: markerInfo.iconSize,
                    height: markerInfo.iconSize,
                    point: LatLng(markerInfo.latitude, markerInfo.longitude),
                    child: Column(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: markerInfo.iconColor,
                          size: markerInfo.iconSize,
                        ),
                        Text(markerInfo.text),
                      ],
                    ),
                  ))
              .toList(),
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

// Class to represent marker information
class MarkerInfo {
  final double latitude;
  final double longitude;
  final Color iconColor;
  final double iconSize;
  final String text;

  MarkerInfo({
    required this.latitude,
    required this.longitude,
    required this.iconColor,
    required this.iconSize,
    required this.text,
  });
}
