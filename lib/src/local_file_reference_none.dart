import 'dart:typed_data';

import 'package:flutter/widgets.dart';

const _unimplemntedError = "LocalFileReference not implemented for this platform";

Future<Uint8List> getData(String path) {
  throw UnimplementedError(_unimplemntedError);
}

ImageProvider getProvider(String path) {
  throw UnimplementedError(_unimplemntedError); 
}