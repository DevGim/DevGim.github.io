import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
// import 'marker_data.dart';

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

void getMarkersFromFile(String fileName) async {
  // Read the CSV file
  final input = File(fileName).readAsString();

  // Split lines using LineSplitter (handles both CRLF and LF)
  List<String> lines =
      LineSplitter.split(await input).toList(); // Convert to List

  // Create a CSV converter
  final CsvToListConverter converter = CsvToListConverter();

  // Convert CSV to List
  List<List<dynamic>> csvList =
      lines.map((line) => converter.convert(line)).toList();

  // Define the header of the CSV file
  List<String> headers = csvList[0].map((dynamic e) => e.toString()).toList();

  // Print the headers
  print(headers);

  // Remove the header from the list
  csvList.removeAt(0);

  // Print the rows
  List<MarkerInfo> markers = [];
  for (var row in csvList) {
    print(row);
    print(row[0][0]); // storeName
    print(row[0][0]); // long, lang
    print(row[0][0]); // long
  }

  markers.add(MarkerInfo(
    latitude: 37.411549,
    longitude: 127.1298651,
    storeName: "Marker 1",
  ));

  print('marker has ');
  print(markers.length);
}

void getMarkers() {
// List<MarkerInfo> getMarkers() {
  // List<MarkerInfo> asdf;

  // return asdf;
}

void main() {
  const String fileName = '../res/output2.csv';
  // const String _fileName = '../res/output.csv';
  getMarkersFromFile(fileName);
}
