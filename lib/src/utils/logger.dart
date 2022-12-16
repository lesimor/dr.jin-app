// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:logger/logger.dart';

final logger = new Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    lineLength: 50,
    errorMethodCount: 3,
    colors: true,
    printEmojis: true,
  ),
);

JsonEncoder encoder = new JsonEncoder.withIndent('  ');

String mapToString(Map map) {
  return encoder.convert(map);
}
