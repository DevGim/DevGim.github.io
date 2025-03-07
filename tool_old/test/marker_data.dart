// marker_data.dart
import 'package:flutter/material.dart';

const MaterialColor iconColorBeauty = Colors.red;
const int iconSize = 40;

class MarkerInfo {
  final String storeName;
  final double latitude;
  final double longitude;

  MarkerInfo({
    required this.storeName,
    required this.latitude,
    required this.longitude,
  });
}

List<MarkerInfo> markers = [
  MarkerInfo(
    latitude: 37.411549,
    longitude: 127.1298651,
    storeName: "Marker 1",
  ),
  MarkerInfo(
    latitude: 37.376703,
    longitude: 127.116195,
    storeName: "Marker 2",
  ),
];
