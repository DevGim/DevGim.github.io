import 'csv_processor.dart';
import 'marker_info.dart';

void main() {
  runMain();
}

Future<void> runMain() async {
  CsvProcessor csvProcessor = CsvProcessor();

  List<MarkerInfo> markers = [];
  // await Future.delayed(Duration.zero); // 비동기 처리를 위해 잠시 대기
  await csvProcessor.processCSVFile('with_geo_mod.csv', markers);

  // 'processCSVFile' 함수가 완료될 때까지 기다립니다.

  // 이제 'markers' 리스트를 main 함수에서 필요한 대로 사용할 수 있습니다.
  // printMarkers(markers);
  print(markers.length);
}
