import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:online_study/features/home/controller/lesson_controller.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/services/network_caller.dart';

class ManageAccountScreenController extends GetxController {
  final LessonController lessonController = Get.find<LessonController>();
  final nameController = TextEditingController();
  final selectedImage = Rx<File?>(null);
  final isLoading = false.obs;

  /// Pick Image from Gallery
  /// ================================
  Future<void> pickImageGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image");
    }
  }

  /// ================================
  /// Update User Image & Name (PATCH)
  /// ================================
  Future<void> updateUserProfile() async {
    if (nameController.text.trim().isEmpty && selectedImage.value == null) {
      Get.snackbar("Info", "Nothing to update");
      return;
    }

    isLoading.value = true;

    try {
      /// -------- Prepare Data --------
      final jsonData = {
        if (nameController.text.trim().isNotEmpty)
          'fullName': nameController.text.trim(),
      };

      /// -------- Detect Image Mime --------
      MediaType? mediaType;
      if (selectedImage.value != null) {
        final mimeType = lookupMimeType(selectedImage.value!.path);
        if (mimeType != null && mimeType.startsWith('image/')) {
          mediaType = MediaType(mimeType.split('/')[0], mimeType.split('/')[1]);
        }
      }

      /// -------- API Call --------
      final response = await NetworkCaller().multipartRequest(
        url: ApiEndpoints.updateProfile,
        method: 'PATCH',
        filePath: selectedImage.value?.path,
        fieldName: selectedImage.value != null ? 'file' : null,
        fileContentType: mediaType,
        additionalFields: {'data': jsonEncode(jsonData)},
      );

      if (response.isSuccess) {
        Get.snackbar("Success", "Profile updated successfully",
            backgroundColor: Colors.green, colorText: Colors.white);

        /// -------- SERVER SYNC (SAFE) --------
        await lessonController.fetchUser(force: true);

        selectedImage.value = null;
      } else {
        Get.snackbar("Error", response.errorMessage);
        log("Error: ${response.errorMessage}");
      }
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
