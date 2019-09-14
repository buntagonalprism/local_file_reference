import 'dart:html' as html;

import 'dart:typed_data';

import 'package:flutter/widgets.dart';

import 'local_file_reference.dart';

class LocalFileReferenceImpl implements LocalFileReference {
  final String identifier;
  final html.File file;
  final Uint8List bytes;

  LocalFileReferenceImpl(this.identifier, this.file, this.bytes);

  String get fileName => file.name;

  String get localFilePath => identifier;

  Future<int> get length => Future<int>.value(bytes.lengthInBytes);

  @override
  Widget asImageWidget({double height, double width, BoxFit fit}) {
    return Image.memory(
      bytes,
      height: height,
      width: width,
      fit: fit,
    );
  }
}