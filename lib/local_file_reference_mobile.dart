import 'dart:io';

import 'package:flutter/widgets.dart';

import 'local_file_reference.dart';

class LocalFileReferenceImpl implements LocalFileReference {
  final File file;
  final String fileName;

  LocalFileReferenceImpl(this.file, this.fileName);

  @override
  String get localFilePath => file.path;

  @override
  Future<int> get length => file.length();

  @override
  Widget asImageWidget({double height, double width, BoxFit fit}) {
    return Image.file(
      file,
      height: height,
      width: width,
      fit: fit,
    );
  }
}