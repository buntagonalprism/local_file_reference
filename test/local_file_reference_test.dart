import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_file_reference/local_file_reference.dart';

void main() {
  const MethodChannel channel = MethodChannel('local_file_reference');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await LocalFileReference.platformVersion, '42');
  });
}
