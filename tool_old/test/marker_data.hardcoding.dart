// marker_data.dart
import 'package:flutter/material.dart';

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

List<MarkerInfo> markers = [
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
