// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';

class StudentProvider with ChangeNotifier {
  File? image;

  Future<void> getPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final photoSave = File(photo.path);
      image = photoSave;
      notifyListeners();
    }
  }
}

