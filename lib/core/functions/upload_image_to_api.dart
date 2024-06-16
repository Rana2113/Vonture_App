import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<List<File>> uploadImagesToAPI(List<XFile> images) async {
  List<File> files = [];
  for (var image in images) {
    File file = File(image.path);
    files.add(file);
  }
  return files;
}
