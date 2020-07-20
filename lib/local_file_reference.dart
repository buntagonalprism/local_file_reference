import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';

import './src/local_file_reference_base.dart' as base;

class LocalFileReference {
  /// Expected to be a path on the local filesystem when on platforms supporting dart:io, 
  /// and an Object URL when on the web. 
  final String path;

  /// Optional name to associate with the file - useful when a file may be copied or
  /// transformed (e.g. scaled) during selection, but the user should be shown the
  /// original name. If not supplied, defaults to the last part of the supplied path. 
  final String originalFileName;
  Uint8List _data;

  LocalFileReference(this.path, {String originalFileName})
      : assert(path != null),
        this.originalFileName = originalFileName ?? path.split('/').last;

  Future<Uint8List> retrieveData() async {
    if (_data == null) {
      _data = await base.getData(path);
    }
    return Future.value(_data);
  }

  bool get hasRetrievedData => _data != null;

  ImageProvider get imageProvider {
    return base.getProvider(path);
  }
}
