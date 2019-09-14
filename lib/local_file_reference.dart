library local_file_reference;


abstract class LocalFileReference {
  String get localFilePath;
  String get fileName;
  Future<int> get length;
}