import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';

void main() async {
  // Read the CSV file
  final input = File('output2.csv').readAsString();

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
  for (var row in csvList) {
    print(row);
  }
}
