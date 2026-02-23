import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

//select gellary image
Future<File?> selectImage() async {
  try {
    final XFile? xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (xfile != null) {
      return File(xfile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}

//calculate reading time
int calculateReadingTime(String contet) {
  final wordCount = contet.split(RegExp(r'\w+')).length;
  return (wordCount / 230).ceil();
}

//date formatter
String dateFormatterddMMMyyyyStyle(DateTime date) {
  return DateFormat("d MMM, yyyy").format(date);
}
