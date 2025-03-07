import 'dart:io';

class Business {
  String name;
  String address;
  String industryInfo;
  String neighborhood;

  Business(
      {required this.name,
      required this.address,
      required this.industryInfo,
      required this.neighborhood});
}

void main() {
  // 파일에서 텍스트 읽어오기
  String filePath = 'seongnamcard.txt';
  String text = File(filePath).readAsStringSync();

  List<Business> businesses = [];

  // 정규표현식을 사용하여 업소 정보 추출
  RegExp exp = RegExp(r'(.+?)\n(.+?)\n');
  Iterable<RegExpMatch> matches = exp.allMatches(text);

  // 데이터를 Dart의 List로 변환
  for (var match in matches) {
    String name = match.group(1)!;
    String info = match.group(2)!;

    // 괄호로 동네 정보 추출
    RegExp expNeighborhood = RegExp(r'\((.+?)\)');
    String? neighborhood = expNeighborhood.hasMatch(info)
        ? expNeighborhood.firstMatch(info)!.group(1)
        : null;

    // 괄호를 제외한 나머지 정보 추출
    String infoWithoutNeighborhood =
        info.replaceAll(RegExp(r'\(.+?\)'), '').trim();

    // 주소와 업종정보 구분
    RegExp expAddressIndustry = RegExp(r'(.+?)\s(.+)');
    var matchAddressIndustry =
        expAddressIndustry.firstMatch(infoWithoutNeighborhood);

    String address = matchAddressIndustry?.group(1) ?? "";
    String industryInfo = matchAddressIndustry?.group(2) ?? "";

    businesses.add(Business(
        name: name,
        address: address,
        industryInfo: industryInfo,
        neighborhood: neighborhood ?? ""));
  }

  // CSV 파일로 저장
  saveToCsv(businesses, 'output.csv');
}

void saveToCsv(List<Business> businesses, String outputFileName) {
  // CSV 문자열 작성
  String csvData = 'Name,Address,IndustryInfo,Neighborhood\n';
  for (var business in businesses) {
    csvData +=
        '${business.name},"${business.address}","${business.industryInfo}","${business.neighborhood}"\n';
  }

  // CSV 파일로 저장
  File(outputFileName).writeAsStringSync(csvData);

  print('CSV 파일이 성공적으로 생성되었습니다: $outputFileName');
}
