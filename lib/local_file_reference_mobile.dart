import 'dart:io';

import 'local_file_reference.dart';

class LocalFileReferenceImpl implements LocalFileReference {
  final File file;
  final String fileName;

  LocalFileReferenceImpl(this.file, this.fileName);

  @override
  String get localFilePath => file.path;

  @override
  Future<int> get length => file.length();
}