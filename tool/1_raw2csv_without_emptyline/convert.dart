import 'dart:io';

void main() {
  // 입력 파일 경로와 출력 파일 경로
  String inputFilePath = 'input.txt';
  String outputFilePath = 'output.csv';

  // 입력 파일 읽기
  List<String> lines = File(inputFilePath).readAsLinesSync();

  // 출력 파일 쓰기
  File output = File(outputFilePath);
  IOSink sink = output.openWrite();

  // 각 행을 3줄씩 읽어서 csv 파일로 쓰기
  for (int i = 0; i < lines.length; i += 3) {
    if (i + 2 < lines.length) {
      String name = lines[i];
      String type = lines[i + 1];
      String addressLine = lines[i + 2];

      // 주소에서 괄호로 둘러싸인 세부 정보 추출
      RegExp regex = RegExp(r'\((.*?)\)');
      Match? match = regex.firstMatch(addressLine);
      String details = match?.group(1) ?? '';

      // 주소에서 세부 정보 제거
      String address = addressLine.replaceAll(RegExp(r'\s?\(.*?\)'), '');

      // CSV 파일에 한 행 추가
      sink.write('"$name","$type","$address","$details"\n');
    }
  }

  // 파일 닫기
  sink.close();
  print('변환 완료: $outputFilePath');
}
