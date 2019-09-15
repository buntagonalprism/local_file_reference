import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class LocalFileReference {
  final String path;
  final String originalFileName;
  Uint8List _data;

  LocalFileReference(this.path, {String originalFileName})
      : assert(path != null),
        this.originalFileName = originalFileName ?? path.split('/').last;

  static const MethodChannel _channel = const MethodChannel('com.buntagon:local_file_reference');

  Future<Uint8List> retrieveData() async {
    if (_data == null) {
      _data = await _channel.invokeMethod('getData');
    }
    return Future.value(_data);
  }

  Uint8List get data {
    if (_data == null) {
      throw "";
    }
    return data;
  }
}
