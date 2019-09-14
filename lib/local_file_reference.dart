library local_file_reference;

import 'package:flutter/widgets.dart';


abstract class LocalFileReference {
  String get localFilePath;
  String get fileName;
  Future<int> get length;
  Widget asImageWidget({double height, double width, BoxFit fit});
}