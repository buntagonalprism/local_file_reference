import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class LocalFileReference {
  final String path;
  final String originalFileName;
  Uint8List _data;
  String _objectUrl;

  LocalFileReference(this.path, {String originalFileName})
      : assert(path != null),
        this.originalFileName = originalFileName ?? path.split('/').last;

  static const MethodChannel _channel = const MethodChannel('com.buntagon/local_file_reference');

  Future<Uint8List> retrieveData() async {
    if (_data == null) {
      final result = await _channel.invokeMethod('getData', {'path': path});
      if (result is Uint8List) {
        _data = result;
      } else {
        final resultMap = Map.from(result);
        _data = resultMap['data'];
        _objectUrl = resultMap['objectUrl'];
      }
    }
    return Future.value(_data);
  }

  bool get hasRetrievedData => _data != null;

  /// Data must be loaded before this image provider can be retrieved. 
  /// Image.memory(file.data) does not work on web - use this image provider
  /// instead - retireving data first. 
  ImageProvider get imageProvider {
    if (_data == null) {
      throw "Data has not been retrieved. Await file.retrieveData() to ensure data has been loaded and check file.hasRetrievedData before accessing imageProvider";
    }
    if (_objectUrl != null) {
      return NetworkImage(_objectUrl);
    } else {
      return MemoryImage(_data);
    }
  }
}
