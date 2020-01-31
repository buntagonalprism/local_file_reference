import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_file_reference/local_file_reference.dart';

void main() {
  const MethodChannel channel = MethodChannel('local_file_reference');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return Uint8List.fromList(<int>[3, 5, 9]);
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getData', () async {
    final file = LocalFileReference('hello/file');
    expect((await file.retrieveData()), Uint8List.fromList(<int>[3, 5, 9]));
  });
}
