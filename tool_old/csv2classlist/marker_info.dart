// // marker_data.dart
// import 'package:flutter/material.dart';

// const MaterialColor iconColorBeauty = Colors.red;
const int iconSize = 40;

class MarkerInfo {
  final String storeName;
  final String type;
  final String address;
  final String district;
  final double latitude;
  final double longitude;

  MarkerInfo({
    required this.storeName,
    required this.latitude,
    required this.longitude,
    this.type = "",
    this.address = "",
    this.district = "",
  });
}
