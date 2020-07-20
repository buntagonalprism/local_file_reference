import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';


Future<Uint8List> getData(String path) {
  return File(path).readAsBytes();
}

ImageProvider getProvider(String path) {
  return FileImage(File(path));
}