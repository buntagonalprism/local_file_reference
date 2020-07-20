import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;


Future<Uint8List> getData(String path) {
  return http.readBytes(path);
}

ImageProvider getProvider(String path) {
  return NetworkImage(path);
}