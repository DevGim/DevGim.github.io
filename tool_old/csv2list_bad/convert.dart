import 'dart:io';
import 'package:csv/csv.dart';

class MarkerInfo {
  final double latitude;
  final double longitude;
  final String name;

  MarkerInfo({
    required this.latitude,
    required this.longitude,
    required this.name,
  });
}

Future<List<MarkerInfo>> readMarkersFromCSV(String filePath) async {
  List<MarkerInfo> markers = [];

  try {
    print("CSV 파일을 읽는 중...");
    String csvData = await File(filePath).readAsString();

    print("CSV 파일 내용:");
    print(csvData);

    List<List<dynamic>> csvTable = const CsvToListConverter().convert(csvData);

    print("CSV 파일 테이블:");
    for (var row in csvTable) {
      print(row);
    }

    // Include header and data in csvRows
    List<List<dynamic>> csvRows = List.from(csvTable);

    print("CSV 파일 행들:");
    for (var row in csvRows) {
      print(row);
    }

    convertRow(csvRows, markers);

    print("CSV 파일 읽기가 완료되었습니다.");
  } catch (e) {
    print("CSV 파일 읽기 오류: $e");
  }

  return markers;
}

void convertRow(List<List<dynamic>> csvRows, List<MarkerInfo> markers) {
  String coordinateKeyword = "Coordinate";

  // Find the index of the Coordinate column
  List<dynamic> header = csvRows.first;
  int coordinateIndex = header.indexOf(coordinateKeyword);

  if (coordinateIndex == -1) {
    print("Error: Coordinate column not found in the header");
    return;
  } else {
    print("Coordinate column found at index: $coordinateIndex");
  }

  for (int rowIndex = 1; rowIndex < csvRows.length; rowIndex++) {
    List<dynamic> row = csvRows[rowIndex];
    print("행을 처리하고 있습니다 (행 번호: $rowIndex): $row");

    try {
      // Use the found coordinateIndex to access the Coordinate column
      String coordinate = row[coordinateIndex].toString();

      // Extract latitude and longitude from the coordinate string
      List<String> coordinates =
          coordinate.replaceAll("(", "").replaceAll(")", "").split(",");
      double latitude = double.tryParse(coordinates[0]) ?? 0.0;
      double longitude = double.tryParse(coordinates[1]) ?? 0.0;

      markers.add(MarkerInfo(
        latitude: latitude,
        longitude: longitude,
        name: row[0].toString(),
      ));
    } catch (e) {
      print("Error during processing row: $e");
    }
  }
}

void main() async {
  String filename = "output2.csv";
  print("CSV 파일에서 마커 정보를 읽어오는 중...");
  List<MarkerInfo> markers = await readMarkersFromCSV(filename);
  print("읽어온 마커 정보:");
  print(markers);
  print("프로그램이 종료되었습니다.");
}
