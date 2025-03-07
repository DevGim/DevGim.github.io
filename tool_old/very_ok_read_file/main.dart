import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import './csv2classlist.dart';
import './marker_info.dart';

const MaterialColor iconColor = Colors.red;
const double iconSize = 40;
List<MarkerInfo> markers = [];

void main() async {
  CsvProcessor csvProcessor = CsvProcessor();

  // await Future.delayed(Duration.zero); // 비동기 처리를 위해 잠시 대기
  await csvProcessor.processCSVFile('res/with_geo_mod.csv', markers);

  // 'processCSVFile' 함수가 완료될 때까지 기다립니다.

  // 이제 'markers' 리스트를 main 함수에서 필요한 대로 사용할 수 있습니다.
  // printMarkers(markers);
  print(markers.length);

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
                    width: 200,
                    height: iconSize,
                    point: LatLng(markerInfo.latitude, markerInfo.longitude),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.location_pin,
                          color: iconColor,
                          size: iconSize,
                        ),
                        Text(markerInfo.storeName),
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
