import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CemraController extends GetxController {
  Rx<File?> capturedImage = Rx<File?>(null);

  Future<void> openCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      capturedImage.value = File(photo.path);
    }
  }

  void resetImage() {
    capturedImage.value = null;
  }

}