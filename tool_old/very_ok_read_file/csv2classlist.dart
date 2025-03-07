import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import './marker_info.dart';

class CsvProcessor {
  // CSV 파일을 파싱하는 함수
  List<List<dynamic>> parseCSV(String input) {
    List<String> lines = LineSplitter.split(input).toList();
    return lines.map((line) => CsvToListConverter().convert(line)).toList();
  }

  // CSV 파일 헤더를 출력하는 함수
  void printHeaders(List<List<dynamic>> csvList) {
    List<String> headers = csvList[0].map((dynamic e) => e.toString()).toList();
    print(headers);
  }

  // CSV 데이터를 MarkerInfo 객체로 변환하는 함수
  void processCSVData(List<List<dynamic>> csvList, List<MarkerInfo> markers) {
    // 각 행을 MarkerInfo 객체로 변환
    for (var row in csvList) {
      try {
        // 위도와 경도를 파싱하기 전에 유효성을 검사
        var latitude = double.parse(row[0][4].toString());
        var longitude = double.parse(row[0][5].toString());

        // 행을 MarkerInfo 객체로 추가
        markers.add(MarkerInfo(
          storeName: row[0][0].toString(),
          latitude: latitude,
          longitude: longitude,
        ));
      } catch (e) {
        print("행 처리 중 오류: $row");
        print("오류 메시지: $e");
        // 필요에 따라 오류를 처리하십시오. 예를 들어 로깅하거나 행을 건너뛸 수 있습니다.
      }
    }
  }

  // 행 정보를 출력하는 함수
  void printRowInfo(List<dynamic> row) {
    print(
        "0: ${row[0][0]}, 1: ${row[0][1]}, 2: ${row[0][2]}, 3: ${row[0][3]}, 4: ${row[0][4]}, 5: ${row[0][5]}");
    print(
        "0: ${row[0][0].runtimeType}, 1: ${row[0][1].runtimeType}, 2: ${row[0][2].runtimeType}, 3: ${row[0][3].runtimeType}, 4: ${row[0][4].runtimeType}, 5: ${row[0][5].runtimeType}");
  }

  // MarkerInfo 객체를 출력하는 함수
  void printMarkers(List<MarkerInfo> markers) {
    print("\nforEach() 메서드를 사용하여 출력:");
    for (var marker in markers) {
      print(marker.storeName);
    }
  }

  // CSV 파일을 처리하는 함수
  Future<void> processCSVFile(String filePath, List<MarkerInfo> markers) async {
    // CSV 파일 읽기
    final input = await File(filePath).readAsString();

    List<List<dynamic>> csvList = parseCSV(input);

    // 헤더 출력
    printHeaders(csvList);
    // 헤더를 리스트에서 제거
    csvList.removeAt(0);

    // CSV 데이터 처리
    processCSVData(csvList, markers);

    // printMarkers(markers);
    // print(markers.length);
  }
}
